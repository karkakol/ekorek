import 'package:ekorek/config/config.dart';
import 'package:ekorek/di/injector.dart';
import 'package:ekorek/service/remote_config_service/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SetupState {
  final bool isInitialized;
  const SetupState({required this.isInitialized});
}

class SetupStateProvider extends HookStateProviderWidget<SetupState> {
  const SetupStateProvider({Key? key}) : super(key: key);

  @override
  SetupState use() {
    final isInitializedValue = useState<bool>(false);
    final remoteConfigService = useInjected<RemoteConfigService>();

    Future<void> load() async {
      Config.remote = (await remoteConfigService.get())!;
    }

    useSimpleEffect(() async {
      await load();
      isInitializedValue.value = true;
    }, []);

    return SetupState(isInitialized: isInitializedValue.value);
  }
}
