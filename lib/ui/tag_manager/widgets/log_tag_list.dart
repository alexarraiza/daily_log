import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:flutter/material.dart';

import 'log_tag_item.dart';

class LogTagList extends StatelessWidget {
  const LogTagList({
    Key? key,
    required this.tags,
    required this.onTapItem,
    this.bottomPadding = true,
    this.shrinkWrap = true,
    this.onDeleteItem,
  }) : super(key: key);

  final List<LogTagModel> tags;
  final Function(LogTagModel tag) onTapItem;
  final Function(LogTagModel tag)? onDeleteItem;
  final bool bottomPadding;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        return LogTagItem(
          tag: tags[index],
          onTap: onTapItem,
          onDelete: onDeleteItem,
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 0,
      ),
      itemCount: tags.length,
      padding: bottomPadding ? EdgeInsets.only(bottom: 60) : null,
    );
  }
}
