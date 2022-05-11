import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:firebase_core/firebase_core.dart';

class SetupState {
  final bool isInitialized;
  const SetupState({required this.isInitialized});
}

class SetupStateProvider extends HookStateProviderWidget<SetupState> {
  const SetupStateProvider({Key? key}) : super(key: key);

  @override
  SetupState use() {
    final isInitializedValue = useState<bool>(false);

    Future<void> load() async {
     await Firebase.initializeApp();
    }

    useSimpleEffect(() async {
      await Future.wait([
        load(),
        Future.delayed(Duration(seconds: 1)), // workaround: ensure long enough wait to prevent startup lag
      ]);
      isInitializedValue.value = true;
    }, []);
    return SetupState(isInitialized: isInitializedValue.value);
  }
}
