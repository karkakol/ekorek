import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekorek/model/remote_config/remote_config.dart';

class RemoteConfigService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RemoteConfigService();

  Future<RemoteConfig?> get() async {
    try {
      final result = (await _firestore.collection('data').doc('config').get()).data();
      return RemoteConfig.fromJson(result!);
    } catch(e) {
      print("Error: $e");
    }
    return null;
  }
}
