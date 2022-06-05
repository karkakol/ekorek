import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/subjects_picker/subject_item.dart';
import 'package:ekorek/config/config.dart';
import 'package:ekorek/model/subject/subject.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class SubjectsPicker extends HookWidget {
  final IList<Subject>? initialValue;

  const SubjectsPicker({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjects = Config.remote.subjects;
    final state = useState<IList<Subject>>(initialValue ?? IList());
    final names = state.value.map((e) => e.name).toList();

    update(Subject subject) => state.value = state.value.map((e) => e.name == subject.name ? subject : e).toIList();
    remove(Subject subject) => state.value = state.value.removeWhere((e) => e.name == subject.name);
    add(Subject subject) => state.value = state.value.add(subject);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          Divider(height: 1, thickness: 1),
          ListView.builder(
            shrinkWrap: true,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final name = subjects[index];
              final subject = state.value.findOrNull((e) => e.name == name) ??
                  Subject(
                    name: name,
                    pricePerHour: 0,
                  );
              return SubjectItem(
                subject: subject,
                onChanged: (subject) {
                  if (names.contains(name)) {
                    if (subject.pricePerHour <= 0)
                      remove(subject);
                    else
                      update(subject);
                  } else
                    add(subject);
                },
                selected: names.contains(name),
                onTap: () {
                  if (names.contains(name))
                    remove(subject);
                  else
                    add(subject);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Button(onTap: () => context.navigator.pop(state.value), text: 'Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Subject",
              style: context.themeData.textTheme.headline6,
            ),
          ),
          Expanded(
            child: Text(
              "Price per hour",
              style: context.themeData.textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

  static Future<IList<Subject>?> pick({required BuildContext context, required IList<Subject> initialValue}) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AnimatedPadding(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SubjectsPicker(initialValue: initialValue),
      ),
    );
  }
}
