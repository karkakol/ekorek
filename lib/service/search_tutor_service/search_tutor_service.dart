import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekorek/app/collections_names.dart';
import 'package:ekorek/model/user/user.dart' as model;

class SearchTutorService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<model.User>> searchTutors(String phrase)async {

    final users = _firestore.collection(CollectionNames.users);
    final tutors = users.where('runtimeType', isEqualTo: "tutor");

    final searchByFirstName = await tutors.where("firstName",isGreaterThanOrEqualTo:phrase )
    .where("firstName", isLessThanOrEqualTo: phrase+'~').get();

    // final searchByLastName = tutors.where("lastName",isGreaterThanOrEqualTo:phrase )
    //     .where("firstName", isLessThanOrEqualTo: phrase+'~');

    //todo uncoment later when cities will be available
    // final searchByCity = tutors.where("city",isGreaterThanOrEqualTo:phrase )
    //     .where("firstName", isLessThanOrEqualTo: phrase+'~');


    final dupa = 1;
    return <model.User>[];



  }
}