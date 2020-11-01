import 'package:daily_log/ui/tag_manager/tag_manager.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = 'settings/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings_screen_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppSettings(context),
            _buildAbout(context),
          ],
        ),
      ),
    );
  }

  Column _buildAppSettings(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            AppLocalizations.of(context).settings_screen_app_settings_section,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(Icons.local_offer_outlined),
          title: Text(AppLocalizations.of(context).settings_screen_manage_tags),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, TagManagerScreen.routeName),
        ),
        Divider(),
      ],
    );
  }

  Column _buildAbout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            AppLocalizations.of(context).settings_screen_about_section,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(Icons.help_outline),
          title: Text(AppLocalizations.of(context).settings_screen_about_this_app),
          onTap: () => showAboutDialog(
            context: context,
          ),
        ),
        Divider(),
      ],
    );
  }
}
