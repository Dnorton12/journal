import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  late void Function() _updateTheme;

  AppDrawer(Function () updateTheme) {
    this._updateTheme = updateTheme;
  }

  @override
  State<StatefulWidget> createState() => _AppDrawerState(_updateTheme);
}

// holds the drawer where the light and dark mode can be toggled
class _AppDrawerState extends State<AppDrawer> {
  final void Function() _updateTheme;

  bool _darkMode = true;

  _AppDrawerState(void Function() this._updateTheme);

  bool get isDark => _darkMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            children: [
              const DrawerHeader(
                child: Text('Settings'),
              ),
              SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: _darkMode,
                  onChanged: (bool value) {
                    if (_darkMode == true) {
                      _darkMode = false;
                      _updateTheme();
                    } else {
                      _darkMode = true;
                      _updateTheme();
                    }
                  }
              )
            ]
        )
    );
  }
}
