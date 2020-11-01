import 'package:badges/badges.dart';
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
      leading: Badge(
        badgeContent: Text(
          tag.tag,
          style: TextStyle(color: tag.color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
        ),
        badgeColor: tag.color,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(4),
        animationType: BadgeAnimationType.fade,
      ),
      onTap: () => onTap(tag),
    );
  }
}
