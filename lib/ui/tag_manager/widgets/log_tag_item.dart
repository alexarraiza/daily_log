import 'package:daily_log/ui/common/log_tag.dart';
import 'package:flutter/material.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

class LogTagItem extends StatelessWidget {
  const LogTagItem({
    Key key,
    @required this.tag,
    @required this.onTap,
  }) : super(key: key);

  final LogTagModel tag;
  final Function(LogTagModel tag) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: LogTag(tag: tag),
      onTap: () => onTap(tag),
    );
  }
}
