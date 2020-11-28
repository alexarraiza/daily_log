import 'dart:ui';

import 'package:daily_log/logic/log_tag/log_tag_cubit.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/tag_manager/widgets/log_tag_form.dart';
import 'package:daily_log/ui/tag_manager/widgets/log_tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
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
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tag_manager_screen_title),
        ),
        body: BlocBuilder<LogTagsCubit, LogTagsState>(
          builder: (context, state) {
            if (state is LogTagsFetched) {
              return LogTagList(
                tags: state.tags,
                onTapItem: _addOrEditTag,
                onDeleteItem: (tag) => BlocProvider.of<LogTagsCubit>(context).deleteTag(tag),
                shrinkWrap: false,
              );
            } else {
              return Center(child: Text(AppLocalizations.of(context).placeholder_unexpected_state));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _addOrEditTag(null),
          label: Text(AppLocalizations.of(context).tag_manager_screen_add_tag),
          icon: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _addOrEditTag(LogTagModel tag) {
    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          LogTagForm(
            tag: tag,
          ),
        ],
      ),
    ).then((_) {
      BlocProvider.of<LogTagCubit>(context).resetState();
      BlocProvider.of<LogTagsCubit>(context).fetchTags();
    });
  }
}
