import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekorek/model/user/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserService();

  Future<void> createUser({required String uid, required model.User user}) async {
    await _firestore.collection('users').doc(uid).set(user.toJson());
  }

  Future<model.User?> getCurrentUser() async {
    final uid = _auth.currentUser?.uid;
    return uid != null  ? await getUser(uid) : null;
  }

  Future<model.User?> getUser(String uid) async {
    final result = (await _firestore.collection('users').doc(uid).get()).data();
    if (result != null) return model.User.fromJson(result);
    return null;
  }
}
