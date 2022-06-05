import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekorek/app/collections_names.dart';
import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/model/user/user_type.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

  Future<IList<model.User>> getTutorsUsers() async {
    final usersQuery = _firestore.collection(CollectionNames.users);
    final tutorsResponse = (await usersQuery.where('runtimeType', isEqualTo:  UserType.TUTOR.display).get())
        .docs
        .map((e) => model.User.fromJson(e.data()));

    return tutorsResponse.toIList();
  }

  Stream<IList<model.User>> tutorsStream() {
    return _firestore.collection(CollectionNames.users).snapshots().map((event) => event.docs
        .where((e) => e.data()['type'] == UserType.TUTOR.display)
        .map((e) => model.User.fromJson(e.data()))
        .toIList());
  }
}
