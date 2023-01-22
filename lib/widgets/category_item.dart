import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';
import '../models/category_meals_screen_route_arguments.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  final String title;

  const CategoryItem(
      {Key? key, required this.id, required this.color, required this.title})
      : super(key: key);

  ///this below Navigator..push can also be achieved by
  ///using routes strategy that's why i'm commenting this
  ///because bigger apps is suitable for routes strategy
  void selectCategory(BuildContext buildContext) {
    // Navigator.of(buildContext)
    //     .push(MaterialPageRoute(builder: (_) => CategoryMealsScreen(categoryId: id, categoryTitle: title)));
    Navigator.pushNamed(buildContext, CategoryMealsScreen.routeName,
        arguments: CategoryMealsScreenRoutesArguments(
            categoryMealsScreenRoutesArgumentId: id,
            categoryMealsScreenRouteArgumentTitle: title));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        // this below line theming style gives error
        //child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
