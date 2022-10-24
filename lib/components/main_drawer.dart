import 'package:flutter/material.dart';
import 'package:meals/utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _createItem(
    IconData icon,
    String label,
    Function() onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.bottomRight,
            child: Text(
              'Vamos cozinhar',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _createItem(Icons.restaurant, 'Refeições', () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          }),
          _createItem(Icons.settings, 'Configurações', () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
          }),
        ],
      ),
    );
  }
}
