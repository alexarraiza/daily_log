import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogEntryItem extends StatelessWidget {
  final LogEntryModel logEntry;
  final Function(LogEntryModel entry) onTap;

  const LogEntryItem(this.logEntry, {Key key, this.onTap})
      : assert(logEntry != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildFilledEntry(context);
  }

  ListTile _buildFilledEntry(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(logEntry.entry),
      ),
      subtitle: (logEntry.tags != null && logEntry.tags.length > 0)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // TODO: ADD OTHER TAGS
                ],
              ),
            )
          : null,
      onTap: () => onTap(logEntry),
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
