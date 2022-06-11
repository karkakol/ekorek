import 'package:ekorek/service/user_service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ekorek/model/user/user.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService;

  AuthService({required this.userService});

  Future<void> signUp({required String email, required String password, required model.User user}) async {
    final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final id = credentials.user!.uid;
    await userService.createUser(uid: id, user: user.copyWith(id: id));
  }

  Future<UserCredential?> signIn({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
