import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/common/log_tag.dart';
import 'package:daily_log/ui/home/widgets/log_entry_add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

openLogEntryBottomsheet(BuildContext context,
        {required DateTime selectedDate, LogEntryModel? logEntry, Function()? whenComplete}) =>
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (context) => LogEntryForm(
        selectedDate: selectedDate,
        logEntry: logEntry,
      ),
    ).whenComplete(
      whenComplete ?? () {},
    );

class LogEntryForm extends StatefulWidget {
  final LogEntryModel? logEntry;
  final DateTime selectedDate;

  const LogEntryForm({
    Key? key,
    this.logEntry,
    required this.selectedDate,
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
    return BlocListener<LogEntryCubit, LogEntryState>(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildForm(),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildButtonBar(),
            ),
          ],
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              labelText: AppLocalizations.of(context)!.log_entry_form_entry_label,
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
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: currentEntry.tag == null
                ? LogTag(
                    leading: Icons.add,
                    tag: LogTagModel(AppLocalizations.of(context)!.log_entry_form_add_tag,
                        Theme.of(context).primaryColor, DateTime.now(), DateTime.now()),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => _buildAddTagDialog(),
                    ),
                  )
                : LogTag(
                    tag: currentEntry.tag!,
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
      onTagPressed: (tag) => setState(() {
        currentEntry = currentEntry.copyWith(tag: tag);
        Navigator.pop(context);
      }),
      onDeselectPressed: () => setState(() {
        currentEntry = currentEntry.copyWithNullTag();
        Navigator.pop(context);
      }),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildButtonBar() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onPressed: () {
        if (_entryTextController.text.isNotEmpty) {
          setState(() {
            currentEntry = currentEntry.copyWith(entry: _entryTextController.text);
            BlocProvider.of<LogEntryCubit>(context).saveLogEntry(currentEntry);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(AppLocalizations.of(context)!.log_entry_form_save_button),
      ),
    );
  }
}
