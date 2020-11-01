import 'package:flutter/material.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

import 'log_tag_item.dart';

class LogTagList extends StatelessWidget {
  const LogTagList({
    Key key,
    @required this.tags,
    @required this.onTapItem,
    this.bottomPadding = true,
  })  : assert(tags != null),
        super(key: key);

  final List<LogTagModel> tags;
  final Function(LogTagModel tag) onTapItem;
  final bool bottomPadding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return LogTagItem(
          tag: tags[index],
          onTap: onTapItem,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: tags.length,
      padding: bottomPadding ? EdgeInsets.only(bottom: 60) : null,
    );
  }
}
