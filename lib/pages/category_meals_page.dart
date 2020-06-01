import 'package:flutter/material.dart';

import './../widgets/meal_item.dart';

import './../dummy_data.dart';

class CategoryMealsPage extends StatelessWidget {
  static const String routeName = 'category-meals';
  /*
  final String categoryId;
  final String categoryTitle;

  CategoryMealsPage(this.categoryId, this.categoryTitle);
  */

  @override
  Widget build(BuildContext context) {
    final routeArgs =  ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((item) {
      return (item.categories.contains(categoryId));
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final categoryMeal = categoryMeals[index];
          return MealItem(
            id: categoryMeal.id,
            title: categoryMeal.title,
            imageUrl: categoryMeal.imageUrl,
            duration: categoryMeal.duration,
            complexity: categoryMeal.complexity,
            affordability: categoryMeal.affordability,
          );
        },
        itemCount: categoryMeals.length,
      )
    );
  }
}