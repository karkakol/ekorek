class Config {
  final String appName;

  const Config._({required this.appName});

  static final dev = Config._(appName: "Ekorek (dev)");
  static final prod = Config._(appName: "Ekorek (prod)");

  static late final Config current;
}
