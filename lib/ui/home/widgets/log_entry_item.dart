import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/ui/common/log_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LogEntryItem extends StatelessWidget {
  final LogEntryModel logEntry;
  final Function(LogEntryModel entry) onTap;
  final Function(LogEntryModel entry) onDelete;

  const LogEntryItem(
    this.logEntry, {
    Key key,
    this.onTap,
    this.onDelete,
  })  : assert(logEntry != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildFilledEntry(context);
  }

  Widget _buildFilledEntry(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        if (onDelete != null)
          IconSlideAction(
            icon: Icons.delete,
            caption: 'Delete',
            color: Colors.red,
            onTap: () => onDelete(logEntry),
          )
      ],
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(logEntry.entry),
        ),
        trailing: (logEntry.tag != null) ? LogTag(tag: logEntry.tag) : null,
        onTap: onTap != null ? () => onTap(logEntry) : null,
      ),
    );
  }
}
