import 'package:utopia_hooks/utopia_hooks.dart';

class FullState<T> {
  final T value;
  final Function(T) setValue;

  const FullState({
    required this.value,
    required this.setValue,
  });
}

FullState<T> useFullState<T>(T value) {
  final vState = useState<T>(value);

  return FullState(
    value: vState.value,
    setValue: (nv) => vState.value = nv,
  );
}
