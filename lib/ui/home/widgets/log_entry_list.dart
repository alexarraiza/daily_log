import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/ui/home/widgets/log_entry_item.dart';
import 'package:daily_log/ui/tag_manager/tag_manager.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogEntryList extends StatelessWidget {
  const LogEntryList(
    this._list, {
    Key? key,
    this.bottomPadding = true,
    this.shrinkWrap = true,
  }) : super(key: key);

  final List<LogEntryModel> _list;
  final bool bottomPadding;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          itemBuilder: (context, index) => LogEntryItem(
            _list[index],
            onTap: (entry) => _addOrEditEntry(entry),
            onDelete: (entry) => BlocProvider.of<LogEntriesCubit>(context).deleteEntry(entry),
          ),
          separatorBuilder: (context, index) => Divider(
            height: 0,
          ),
          itemCount: _list.length,
          padding: bottomPadding ? EdgeInsets.only(bottom: 60) : null,
          shrinkWrap: shrinkWrap,
        ),
        SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    child: IconButton(
                      onPressed: () => _addOrEditEntry(null),
                      icon: Icon(Icons.add),
                      color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                  ),
                  Container(
                    child: VerticalDivider(
                      color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(context, TagManagerScreen.routeName),
                      icon: Icon(Icons.local_offer_outlined),
                      color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addOrEditEntry(LogEntryModel? entry) {}
}
