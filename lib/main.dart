import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;
  Settings _settings = Settings();
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isGlutenFree && !meal.isLactoseFree;
        final filterVegan = settings.isGlutenFree && !meal.isVegan;
        final filterVegetarian = settings.isGlutenFree && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primaryColor: Colors.pink,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink,
          ).copyWith(
            secondary: Colors.amber,
          ),
          fontFamily: 'Raleway',
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                  fontSize: 20, fontFamily: 'RobotoCondensed'))),
      routes: {
        AppRoutes.home: (_) {
          return TabsScreen(
            favoriteMeals: _favoriteMeals,
          );
        },
        AppRoutes.categoriesMeals: (_) {
          return CategoriesMealsScreen(
            meals: _availableMeals,
          );
        },
        AppRoutes.mealDetail: (_) {
          return MealDetailScreen(
            onToggleFavorite: _toggleFavorite,
            isFavorite: _isFavorite,
          );
        },
        AppRoutes.settings: (_) {
          return SettingsScreen(
            settings: _settings,
            onSettingsChange: _filterMeals,
          );
        },
      },
    );
  }
}
