import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/ui/home/widgets/log_entry_item.dart';
import 'package:flutter/material.dart';

class LogEntryList extends StatelessWidget {
  const LogEntryList(this._list, {Key key, this.onTapItem, this.bottomPadding = true, this.shrinkWrap = true})
      : super(key: key);

  final List<LogEntryModel> _list;
  final Function(LogEntryModel entry) onTapItem;
  final bool bottomPadding;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => LogEntryItem(
        _list[index],
        onTap: onTapItem,
      ),
      separatorBuilder: (context, index) => Divider(
        height: 0,
      ),
      itemCount: _list.length,
      padding: bottomPadding ? EdgeInsets.only(bottom: 60) : null,
      shrinkWrap: shrinkWrap,
    );
  }
}
