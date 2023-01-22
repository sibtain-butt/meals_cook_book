import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/category_meals_screen_route_arguments.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoryMealsScreen({super.key, required this.availableMeals});

  static const routeName = '/category_meals_screen';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  ///below few commented lines we don't need because
  ///this class constructor is already defined in the main.dart
  ///file using key identifier and define that constructor arguments
  ///in the category_item.dart file & here we just need to extract
  ///the arguments from the pushName(...arguments: {...some args...})
  ///that is stored in a Map<String, String> or any list of object
  ///because arguments can be anything
  ///
  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen(
  //     {Key? key, required this.categoryId, required this.categoryTitle})
  //     : super(key: key);
  late String categoryTitle;
  late List<Meal> filteredCategoryMeals;

  //bool _loadInitData = false; // we don't need it thanks to [late] arguments

  @override
  void initState() {
    // TODO: implement initState
    //we can not use initState() to delete mealId using pop floating action button
    //because of Theme.of(context).primaryColor; context used in a statement
    // we prefer to use didChangeDependencies() method
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //if (_loadInitData == false){ // we don't need if statement because of
    //late argument thanks to flutter

    //this is how we can extract arguments inside the
    // pushName(...arguments: {...Map<String,String>...}) some arguments
    // & store it in new variable but inside the build function
    // by using ModalRoute NOTE: this below single line code is in old flutter
    //version code

    // final routesArguments =
    //ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    //this above line give us error of 'Expected a value of type Map<String?,String,
    //but got one of type '_HashSet<String>' to solve this fix i checked
    // this 'https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments'
    // google documentation and create new argument of each screens inside models folder
    final routesArguments = ModalRoute.of(context)!.settings.arguments
        as CategoryMealsScreenRoutesArguments;

    // final categoryId = routesArguments['id'];
    //instead of using routesArguments['id'] i use this in below line using documentation
    final categoryId = routesArguments.categoryMealsScreenRoutesArgumentId;

    // final categoryTitle = routesArguments['title'];
    categoryTitle = routesArguments.categoryMealsScreenRouteArgumentTitle;
//post-NOTE:in below line i will change dummyMeals.where in below line
//with widget.availableMeals which is a List<Meal> in this.Constructors and
//this availableMeals is passing from Main.dart to show filters in action.
    //filteredCategoryMeals = dummyMeals.where((elementMealInSideMealList) {
    filteredCategoryMeals =
        widget.availableMeals.where((elementMealInSideMealList) {
      return elementMealInSideMealList.categories
          .contains(categoryId); // final String categoryId;
    }).toList();
    //   _loadInitData = true;
    // }//if statement

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void removeSelectedMealIdCategory(categoryId) {
      //print('String categoryId $categoryId');
      setState(() {
        filteredCategoryMeals.removeWhere((elementMealId) {
          return elementMealId.id == categoryId;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: filteredCategoryMeals[index].id,
            title: filteredCategoryMeals[index].title,
            imageUrl: filteredCategoryMeals[index].imageUrl,
            duration: filteredCategoryMeals[index].duration,
            complexity: filteredCategoryMeals[index].complexity,
            affordability: filteredCategoryMeals[index].affordability,
            removeSelectedMealIdCategory: removeSelectedMealIdCategory,
          );
        },
        itemCount: filteredCategoryMeals.length,
      ),
    );
  }
}
