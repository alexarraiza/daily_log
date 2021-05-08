import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/common/log_tag.dart';
import 'package:daily_log/ui/tag_manager/tag_manager.screen.dart';
import 'package:daily_log/ui/tag_manager/widgets/log_tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntryAddTagDialog extends StatelessWidget {
  final Function(LogTagModel tag) onTagPressed;
  final Function() onDeselectPressed;
  final Function() onBackPressed;

  const LogEntryAddTagDialog({
    Key? key,
    required this.onTagPressed,
    required this.onDeselectPressed,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<LogTagsCubit, LogTagsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is LogTagsFetched)
                LogTagList(
                  tags: state.tags,
                  onTapItem: (tag) => onTagPressed(tag),
                  bottomPadding: false,
                ),
              if (state is LogTagsFetched && state.tags.length > 0)
                Divider(
                  height: 0,
                ),
              ListTile(
                leading: LogTag(
                  leading: Icons.add,
                  tag: LogTagModel(AppLocalizations.of(context)!.log_entry_form_add_tag, Theme.of(context).primaryColor,
                      DateTime.now(), DateTime.now()),
                  onTap: () => Navigator.pushNamed(context, TagManagerScreen.routeName)
                      .then((value) => BlocProvider.of<LogTagsCubit>(context).fetchTags()),
                ),
              ),
              ButtonBar(
                children: [
                  MaterialButton(
                    onPressed: () => onDeselectPressed(),
                    child: Text(
                      AppLocalizations.of(context)!.log_entry_form_add_tag_dialog_deselect,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => onBackPressed(),
                    child: Text(
                      AppLocalizations.of(context)!.log_entry_form_add_tag_dialog_ok,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).accentColor)),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
