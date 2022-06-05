import 'package:ekorek/service/search_tutor_service/search_tutor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../../../common/widgets/text_input/text_input.dart';

class SearchTab extends HookWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchTutorService = useInjected<SearchTutorService>();

    final searchFieldState = useFieldState();

    useEffect((){
      searchTutorService.searchTutors(searchFieldState.value);
    },[searchFieldState.value]);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: TextInput(
            fieldState: searchFieldState,
            prefix: Icon(Icons.search),
          ),
        )
      ],
    );
  }
}
