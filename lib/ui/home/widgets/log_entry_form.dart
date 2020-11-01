import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntryForm extends StatefulWidget {
  final LogEntryModel logEntry;
  final DateTime selectedDate;

  const LogEntryForm(
    this.selectedDate, {
    Key key,
    this.logEntry,
  }) : super(key: key);
  @override
  _LogEntryFormState createState() => _LogEntryFormState();
}

class _LogEntryFormState extends State<LogEntryForm> {
  TextEditingController _entryTextController;

  @override
  void initState() {
    super.initState();
    _entryTextController = TextEditingController(
      text: widget.logEntry != null ? widget.logEntry.entry : null,
    );
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
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('error'),
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
      children: [
        Container(
          height: 200,
          child: TextField(
            controller: _entryTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppLocalizations.of(context).log_entry_form_entry_label,
            ),
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            autofocus: true,
          ),
        ),
      ],
    );
  }

  ButtonBar _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context).log_entry_form_back_button,
            style: TextStyle(color: Colors.red),
          ),
        ),
        RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: () {
            LogEntryModel logEntry = widget.logEntry != null
                ? widget.logEntry.copyWith(
                    entry: _entryTextController.text,
                    editDateTime: DateTime.now(),
                  )
                : LogEntryModel(
                    _entryTextController.text,
                    DateTime.now(),
                    DateTime.now(),
                    widget.selectedDate,
                  );
            BlocProvider.of<LogEntryCubit>(context).saveLogEntry(logEntry);
          },
          child: Text(AppLocalizations.of(context).log_entry_form_save_button),
        )
      ],
    );
  }
}
