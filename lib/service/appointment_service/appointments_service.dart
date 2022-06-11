import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekorek/app/collections_names.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';

class AppointmentsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AppointmentsService();

  Future<void> add(Appointment appointment) async {
    Logger().i("Appointment Add: ${appointment.toJson()}");
    await _firestore.collection(CollectionNames.appointments).doc(appointment.uuid).set(appointment.toJson());
  }

  Future<void> cancel(Appointment appointment) async {
    Logger().i("Appointment Remove: ${appointment.toJson()}");
    await _firestore.collection(CollectionNames.appointments).doc(appointment.uuid).delete();
  }

  Future<Appointment?> getAppointmentById(String uuid) async {
    final result = (await _firestore.collection(CollectionNames.appointments).doc(uuid).get()).data();
    if (result != null) return Appointment.fromJson(result);
    return null;
  }

  Future<IList<Appointment>> getStudentAppointments(String studentId) async {
    final collectionRef = _firestore.collection(CollectionNames.appointments);
    final response = (await collectionRef.where('studentId', isEqualTo: studentId).get())
        .docs
        .map((e) => Appointment.fromJson(e.data()));
    Logger().i(response);
    return response.toIList();
  }

  Future<IList<Appointment>> getTutorAppointments(String tutorId) async {
    final collectionRef = _firestore.collection(CollectionNames.appointments);
    final response = (await collectionRef.where('tutorId', isEqualTo: tutorId).get())
        .docs
        .map((e) => Appointment.fromJson(e.data()));
    Logger().i(response);
    return response.toIList();
  }

  Stream<IList<Appointment>> allAppointmentsStream() {
    return _firestore
        .collection(CollectionNames.appointments)
        .snapshots()
        .map((event) => event.docs.map((e) => Appointment.fromJson(e.data())).toIList());
  }
}
