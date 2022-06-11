import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/screen/create_appointment/state/create_appointemtn_screen_args.dart';
import 'package:ekorek/screen/home/widgets/tabs/widget/subject_tile.dart';
import 'package:ekorek/screen/home/widgets/tabs/widget/tutor_tile.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

import '../../../../app/state/users/users_state.dart';
import '../../../../common/widgets/text_input/text_input.dart';
import '../../../../config/config.dart';
import '../../../../model/user/user.dart';

class SearchTab extends HookWidget {
  final Function(CreateAppointmentScreenArgs) navigateToCreateAppointment;

  const SearchTab({
    Key? key,
    required this.navigateToCreateAppointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersState = useProvided<UsersState>();

    final remotesSubjects = useRef<List<String>>(Config.remote.subjects);

    final displayedTutorsState = useState<IList<model.UserTutor>>(usersState.tutors);

    final searchFieldState = useFieldState();
    final currentSubject = useState<String>(Config.remote.subjects.first);

    final filterTutors = useCallback<
        IList<model.UserTutor> Function(
      IList<model.UserTutor> allTutors,
      String currentSubject,
      String phrase,
    )>((allUsers, subject, phrase) {
      phrase = phrase.toLowerCase();
      return allUsers
          .where((tutor) =>
              (tutor as UserTutor).subjects[subject] != null &&
              (tutor.city.toLowerCase().contains(phrase) ||
                  tutor.firstName.toLowerCase().contains(phrase) ||
                  tutor.lastName.toLowerCase().contains(phrase)))
          .toIList();
    }, []);

    useEffect(() {
      displayedTutorsState.value = filterTutors(usersState.tutors, currentSubject.value, searchFieldState.value);
    }, [
      currentSubject.value,
      searchFieldState.value,
      usersState.tutors,
    ]);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: TextInput(
              fieldState: searchFieldState,
              prefix: const Icon(Icons.search),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Wrap(
            children: [
              for (final subject in remotesSubjects.value)
                SubjectTile(
                  onTap: () => currentSubject.value = subject,
                  subjectName: subject,
                  isSelected: subject == currentSubject.value,
                )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TutorTile(
                tutor: displayedTutorsState.value[index],
                subject: currentSubject.value,
                onTap: navigateToCreateAppointment,
              );
            },
            childCount: displayedTutorsState.value.length,
          ),
        )
      ],
    );
  }
}
