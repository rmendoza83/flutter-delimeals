
import 'package:flutter/material.dart';

import './pages/tabs_page.dart';
import './pages/category_meals_page.dart';
import './pages/meal_detail_page.dart';
import './pages/filters_page.dart';

import './dummy_data.dart';

import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    setState(() {
      if (existingIndex >= 0) {
        _favoriteMeals.removeAt(existingIndex);
      } else {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)
        );
      }
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed', 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsPage(_favoriteMeals),
        CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(_availableMeals),
        MealDetailPage.routeName: (ctx) => MealDetailPage(
          _toggleFavorite,
          _isMealFavorite,
        ),
        FiltersPage.routeName: (ctx) => FiltersPage(
          _filters,
          _setFilters
        ),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return null;
      },
    );
  }
}