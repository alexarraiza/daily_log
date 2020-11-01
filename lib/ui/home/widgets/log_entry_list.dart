import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/ui/home/widgets/log_entry.dart';
import 'package:flutter/material.dart';

class LogEntryList extends StatelessWidget {
  final List<LogEntryModel> _list;
  final Function(LogEntryModel entry) onTapItem;

  const LogEntryList(this._list, {Key key, this.onTapItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => LogEntry(
        _list[index],
        onTap: onTapItem,
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: _list.length,
    );
  }
}
