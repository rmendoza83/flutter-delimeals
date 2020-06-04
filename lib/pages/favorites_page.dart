import 'package:flutter/material.dart';

import './../widgets/meal_item.dart';

import './../models/meal.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesPage(
    this.favoriteMeals
  );

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet = start adding some!',
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final favoriteMeal = favoriteMeals[index];
        return MealItem(
          id: favoriteMeal.id,
          title: favoriteMeal.title,
          imageUrl: favoriteMeal.imageUrl,
          duration: favoriteMeal.duration,
          complexity: favoriteMeal.complexity,
          affordability: favoriteMeal.affordability
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}