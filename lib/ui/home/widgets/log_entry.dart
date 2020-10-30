import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LogEntry extends StatelessWidget {
  final String text;
  final List<dynamic> tags;

  const LogEntry({Key key, this.text, this.tags = const []}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return text != null ? _buildFilledEntry() : _buildPlaceholderEntry();
  }

  ListTile _buildFilledEntry() {
    return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(text),
        ),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildAddTagChip(),
              // TODO: ADD OTHER TAGS
            ],
          ),
        ));
  }

  ActionChip _buildAddTagChip() {
    return ActionChip(
      visualDensity: VisualDensity.compact,
      label: Text('add tag'),
      onPressed: () {},
    );
  }

  ListTile _buildPlaceholderEntry() {
    return ListTile();
  }
}
