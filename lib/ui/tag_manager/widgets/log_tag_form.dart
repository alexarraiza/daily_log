import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:daily_log/logic/log_tag/log_tag_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogTagForm extends StatefulWidget {
  final LogTagModel? tag;

  const LogTagForm({Key? key, this.tag}) : super(key: key);

  @override
  _LogTagFormState createState() => _LogTagFormState(tag);
}

class _LogTagFormState extends State<LogTagForm> {
  late TextEditingController _tagTextController;
  late LogTagModel currentTag;

  _LogTagFormState(LogTagModel? tag) {
    if (tag != null) {
      currentTag = tag;
    } else {
      currentTag = LogTagModel(
        '',
        Colors.blueGrey,
        DateTime.now(),
        DateTime.now(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tagTextController = TextEditingController(
      text: currentTag.tag,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tagTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BlocListener<LogTagCubit, LogTagState>(
          listener: (context, state) {
            if (state is LogTagSaved) {
              Navigator.pop(context);
            } else if (state is LogTagSaveError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('error'),
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildForm(),
                    _buildButtonBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                child: CircleAvatar(
                  backgroundColor: currentTag.color,
                ),
                onTap: () => _showColorPicker(),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _tagTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.log_tag_form_input_label,
                ),
                minLines: 1,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.top,
                autofocus: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ButtonBar _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.log_tag_form_back_button,
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor)),
          onPressed: () {
            if (_tagTextController.text.isNotEmpty) {
              setState(() {
                currentTag = currentTag.copyWith(tag: _tagTextController.text);
                BlocProvider.of<LogTagCubit>(context).saveLogTag(currentTag);
              });
            }
          },
          child: Text(AppLocalizations.of(context)!.log_tag_form_save_button),
        )
      ],
    );
  }

  void _showColorPicker() {
    Color pickerColor = currentTag.color;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.log_tag_form_color_picker_title),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: pickerColor,
            onColorChanged: (value) {
              setState(() {
                pickerColor = value;
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.log_tag_form_color_picker_button),
            onPressed: () {
              setState(() => currentTag = currentTag.copyWith(color: pickerColor));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
