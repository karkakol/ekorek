import 'package:ekorek/model/remote_config/remote_config.dart';

class Config {
  final String appName;
  static late final RemoteConfig remote;

  const Config._({required this.appName});

  static final dev = Config._(appName: "Ekorek (dev)");
  static final prod = Config._(appName: "Ekorek (prod)");

  static late final Config current;
}
