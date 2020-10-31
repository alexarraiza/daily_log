import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/ui/home/widgets/log_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntryList extends StatelessWidget {
  final List<LogEntryModel> _list;

  const LogEntryList(this._list, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => index < _list.length
          ? LogEntry(
              text: _list[index].entry,
              tags: _list[index].tags,
            )
          : LogEntry(
              icon: Icons.add,
              text: AppLocalizations.of(context).log_entry_list_new,
              canAddTags: false,
              onTap: () {},
            ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: _list.length + 1,
    );
  }
}
