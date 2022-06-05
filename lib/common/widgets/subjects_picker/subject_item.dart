import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:ekorek/model/subject/subject.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SubjectItem extends HookWidget {
  final Subject subject;
  final bool selected;
  final void Function(Subject) onChanged;
  final void Function() onTap;

  const SubjectItem({
    Key? key,
    required this.subject,
    required this.selected,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fieldState = useFieldState(initialValue: subject.pricePerHour.toString());
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: selected ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                subject.name.toUpperCase(),
                style: context.themeData.textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: TextInput(
                fieldState: fieldState,
                hint: subject.pricePerHour.toString(),
                onChange: (value) {
                  final price = int.tryParse(fieldState.value) ?? 0;
                  onChanged(subject.copyWith(pricePerHour: price));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
