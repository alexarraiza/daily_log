import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:flutter/material.dart';

class LogTag extends StatelessWidget {
  final LogTagModel tag;
  final IconData? leading;
  final Function()? onTap;

  const LogTag({Key? key, required this.tag, this.leading, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: leading != null
          ? Icon(
              leading,
              size: 18,
              color: tag.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            )
          : null,
      onSelected: (value) => this.onTap != null ? this.onTap!() : {},
      selected: false,
      label: Text(
        tag.tag,
        style: TextStyle(color: tag.color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
      ),
      labelPadding: EdgeInsets.only(left: leading == null ? 8 : 4, right: 8, top: 2, bottom: 2),
      backgroundColor: tag.color,
    );
  }
}
