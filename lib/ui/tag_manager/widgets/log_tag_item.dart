import 'package:daily_log/ui/common/log_tag.dart';
import 'package:flutter/material.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LogTagItem extends StatelessWidget {
  const LogTagItem({
    Key key,
    @required this.tag,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  final LogTagModel tag;
  final Function(LogTagModel tag) onTap;
  final Function(LogTagModel tag) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        if (onDelete != null)
          IconSlideAction(
            icon: Icons.delete,
            caption: 'Delete',
            color: Colors.red,
            onTap: () => this.onDelete(tag),
          )
      ],
      child: ListTile(
        leading: LogTag(tag: tag),
        onTap: onTap != null ? () => onTap(tag) : null,
      ),
    );
  }
}
