import 'package:utopia_hooks/utopia_hooks.dart';

class DropdownState<T> {
  final T value;
  final void Function(T) onChanged;
  final List<T> items;

  DropdownState({
    required this.value,
    required this.items,
    required this.onChanged,
  });
}

DropdownState<T> useDropdownState<T>({
  required T initialValue,
  required List<T> items,
  Function(T)? onChanged,
}) {
  final valueState = useState<T>(initialValue);

  return DropdownState(
    value: valueState.value,
    items: items,
    onChanged: (value) {
      valueState.value = value;
      onChanged?.call(value);
    },
  );
}
