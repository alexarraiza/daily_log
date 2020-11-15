import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

class LogTag extends StatelessWidget {
  final LogTagModel tag;

  const LogTag({Key key, @required this.tag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text(
        tag.tag,
        style: TextStyle(color: tag.color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
      ),
      badgeColor: tag.color,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(4),
      toAnimate: false,
    );
  }
}
