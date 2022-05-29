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

    Future<void> load() async {}

    useSimpleEffect(() async {
      await load();
      isInitializedValue.value = true;
    }, []);

    return SetupState(isInitialized: isInitializedValue.value);
  }
}
