import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings settings) onSettingsChange;

  const SettingsScreen({
    Key? key,
    required this.settings,
    required this.onSettingsChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool value) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChange(_settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem gluten',
                  'Só exibe refeições sem gluten',
                  _settings.isGlutenFree,
                  (value) {
                    setState(() {
                      _settings.isGlutenFree = value;
                    });
                  },
                ),
                _createSwitch(
                  'Sem lactóse',
                  'Só exibe refeições sem lactóse',
                  _settings.isLactoseFree,
                  (value) {
                    setState(() {
                      _settings.isLactoseFree = value;
                    });
                  },
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganas',
                  _settings.isVegan,
                  (value) {
                    setState(() {
                      _settings.isVegan = value;
                    });
                  },
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições vegetarianas',
                  _settings.isVegetarian,
                  (value) {
                    setState(() {
                      _settings.isVegetarian = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
