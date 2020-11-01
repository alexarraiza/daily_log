import 'package:flutter/material.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

import 'log_tag_item.dart';

class TagManagerList extends StatelessWidget {
  const TagManagerList({
    Key key,
    @required this.tags,
    @required this.onTapItem,
  })  : assert(tags != null),
        super(key: key);

  final List<LogTagModel> tags;
  final Function(LogTagModel tag) onTapItem;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return LogTagItem(
          tag: tags[index],
          onTap: onTapItem,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: tags.length,
    );
  }
}
