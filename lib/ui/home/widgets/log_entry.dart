import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntry extends StatelessWidget {
  final IconData icon;
  final String text;
  final List<LogTagModel> tags;
  final bool canAddTags;
  final Function() onTap;

  const LogEntry({Key key, this.text, this.tags = const [], this.canAddTags = true, this.icon, this.onTap})
      : assert(text != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildFilledEntry(context);
  }

  ListTile _buildFilledEntry(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(text),
      ),
      subtitle: canAddTags || (tags != null && tags.length > 0)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (canAddTags) _buildAddTagChip(context),
                  // TODO: ADD OTHER TAGS
                ],
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  ActionChip _buildAddTagChip(BuildContext context) {
    return ActionChip(
      visualDensity: VisualDensity.compact,
      label: Text(AppLocalizations.of(context).log_entry_add_tag),
      onPressed: () {},
    );
  }
}
