import 'package:badges/badges.dart';
import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/common/log_tag.dart';
import 'package:daily_log/ui/home/widgets/log_entry_add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntryForm extends StatefulWidget {
  final LogEntryModel? logEntry;
  final DateTime selectedDate;

  const LogEntryForm(
    this.selectedDate, {
    Key? key,
    this.logEntry,
  }) : super(key: key);

  @override
  _LogEntryFormState createState() => _LogEntryFormState(logEntry, selectedDate);
}

class _LogEntryFormState extends State<LogEntryForm> {
  late TextEditingController _entryTextController;
  late LogEntryModel currentEntry;

  _LogEntryFormState(LogEntryModel? entry, DateTime selectedDate) {
    if (entry != null) {
      currentEntry = entry;
    } else {
      currentEntry = LogEntryModel('', DateTime.now(), DateTime.now(), selectedDate);
    }
  }

  @override
  void initState() {
    super.initState();
    _entryTextController = TextEditingController(text: currentEntry.entry);
    BlocProvider.of<LogTagsCubit>(context).fetchTags();
  }

  @override
  void dispose() {
    super.dispose();
    _entryTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BlocListener<LogEntryCubit, LogEntryState>(
          listener: (context, state) {
            if (state is LogEntrySaved) {
              Navigator.pop(context);
            } else if (state is LogEntrySaveError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.log_entry_form_save_error),
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildForm(),
                  _buildButtonBar(),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          child: TextField(
            controller: _entryTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText:
              AppLocalizations.of(context)!.log_entry_form_entry_label,
            ),
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            autofocus: true,
          ),
        ),
        _buildTag(),
      ],
    );
  }

  Widget _buildTag() {
    return BlocBuilder<LogTagsCubit, LogTagsState>(
      builder: (context, state) {
        if (state is LogTagsFetched) {
          var contentColor =
          Theme
              .of(context)
              .primaryColorLight
              .computeLuminance() > 0.5
              ? Colors.black
              : Colors.white;
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: InkWell(
              child: currentEntry.tag == null
                  ? Badge(
                animationType: BadgeAnimationType.fade,
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(4),
                badgeColor: Theme
                    .of(context)
                    .primaryColorLight,
                badgeContent: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 12,
                            color: contentColor,
                          ),
                          Text(
                            AppLocalizations.of(context)!.log_entry_form_add_tag,
                            style: TextStyle(color: contentColor),
                          )
                        ],
                      ),
                    )
                  : LogTag(tag: currentEntry.tag!),
              onTap: () => showDialog(
                context: context,
                builder: (context) => _buildAddTagDialog(),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAddTagDialog() {
    return LogEntryAddTagDialog(
      onTagPressed: (tag) =>
          setState(() {
            currentEntry = currentEntry.copyWith(tag: tag);
            Navigator.pop(context);
          }),
      onDeselectPressed: () =>
          setState(() {
            currentEntry = currentEntry.copyWithNullTag();
        Navigator.pop(context);
      }),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  ButtonBar _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.log_entry_form_back_button,
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor)),
          onPressed: () {
            if (_entryTextController.text.isNotEmpty) {
              setState(() {
                currentEntry = currentEntry.copyWith(entry: _entryTextController.text);
                BlocProvider.of<LogEntryCubit>(context).saveLogEntry(currentEntry);
              });
            }
          },
          child: Text(AppLocalizations.of(context)!.log_entry_form_save_button),
        )
      ],
    );
  }
}
