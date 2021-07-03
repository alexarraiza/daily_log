import 'package:daily_log/logic/log_tag/log_tag_cubit.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/common/our_app_bar.dart';
import 'package:daily_log/ui/tag_manager/widgets/log_tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagManagerScreen extends StatefulWidget {
  static const routeName = 'tag_manager/';

  @override
  _TagManagerScreenState createState() => _TagManagerScreenState();
}

class _TagManagerScreenState extends State<TagManagerScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogTagsCubit>(context).fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogTagCubit, LogTagState>(
      listener: (context, state) {
        if (state is LogTagDeleted) {
          BlocProvider.of<LogTagsCubit>(context).fetchTags();
        }
      },
      child: Scaffold(
        appBar: buildOurAppBar(Text(AppLocalizations.of(context)!.tag_manager_screen_title)),
        body: BlocBuilder<LogTagsCubit, LogTagsState>(
          builder: (context, state) {
            if (state is LogTagsFetched) {
              return LogTagList(
                tags: state.tags,
                shrinkWrap: false,
              );
            } else {
              return Center(child: Text(AppLocalizations.of(context)!.placeholder_unexpected_state));
            }
          },
        ),
      ),
    );
  }
}
