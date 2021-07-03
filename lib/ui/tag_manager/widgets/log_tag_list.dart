import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_tag_item.dart';

class LogTagList extends StatelessWidget {
  const LogTagList({
    Key? key,
    required this.tags,
    this.bottomPadding = true,
    this.shrinkWrap = true,
  }) : super(key: key);

  final List<LogTagModel> tags;
  final bool bottomPadding;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          shrinkWrap: shrinkWrap,
          itemBuilder: (context, index) {
            return LogTagItem(
              tag: tags[index],
              onTap: (tag) => _addOrEditTag(tag),
              onDelete: (tag) => BlocProvider.of<LogTagsCubit>(context).deleteTag(tag),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 0,
          ),
          itemCount: tags.length,
          padding: bottomPadding ? EdgeInsets.only(bottom: 60) : null,
        ),
        SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: IconButton(
                  onPressed: () => _addOrEditTag(null),
                  icon: Icon(Icons.add),
                  color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _addOrEditTag(LogTagModel? tag) {}
}
