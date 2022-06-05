import 'package:ekorek/common/widgets/subjects_picker/subjects_picker.dart';
import 'package:ekorek/model/subject/subject.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SubjectsInput extends HookWidget {
  final IList<Subject> initialValue;
  final void Function(Subject) onChanged;

  const SubjectsInput({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectsState = useState<IList<Subject>>(initialValue);
    return Column(
      children: [
        Row(
          children: [
            Text("Subjects"),
            IconButton(
              onPressed: () async {
                final result = await SubjectsPicker.pick(context: context, initialValue: subjectsState.value);
                if (result != null) subjectsState.value = result;
              },
              icon: Icon(Icons.add_circle_outline_rounded),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: subjectsState.value.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subjectsState.value[index].name.toUpperCase()),
                Text(subjectsState.value[index].pricePerHour.toString()),
              ],
            );
          },
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}
