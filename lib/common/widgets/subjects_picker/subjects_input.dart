import 'package:ekorek/common/widgets/subjects_picker/subjects_picker.dart';
import 'package:ekorek/model/subject/subject.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SubjectsInput extends HookWidget {
  final IList<Subject> subjects;
  final void Function(IList<Subject>) onChanged;

  const SubjectsInput({
    Key? key,
    required this.subjects,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text("Subjects"),
            IconButton(
              onPressed: () async {
                final result = await SubjectsPicker.pick(context: context, initialValue: subjects);
                if (result != null) onChanged(result);
              },
              icon: Icon(Icons.add_circle_outline_rounded),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subjects[index].name.toUpperCase()),
                Text(subjects[index].pricePerHour.toString()),
              ],
            );
          },
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}
