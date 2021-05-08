import 'package:badges/badges.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
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
    var contentColor =
        Theme.of(context).primaryColorLight.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white;

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
                onTap: () =>
                    Navigator.pushNamed(context, TagManagerScreen.routeName)
                        .then((value) =>
                            BlocProvider.of<LogTagsCubit>(context).fetchTags()),
                leading: Badge(
                  shape: BadgeShape.square,
                  borderRadius: BorderRadius.circular(4),
                  badgeColor: Theme.of(context).primaryColorLight,
                  toAnimate: false,
                  badgeContent: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 12,
                        color: contentColor,
                      ),
                      Text(
                        AppLocalizations.of(context)!.log_entry_form_add_tag_dialog_new_tag,
                        style: TextStyle(color: contentColor),
                      )
                    ],
                  ),
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
