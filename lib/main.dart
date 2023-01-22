import 'package:flutter/material.dart';

import './screens/bottom_navigation_bar_screen.dart';
import './screens/filters_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';

import './dummy_data.dart';

import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filtersKeyMap = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = dummyMeals;

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filtersKeyMap = filterData;

      availableMeals = dummyMeals.where((elementMeal) {
        if (filtersKeyMap['gluten'] == true && !elementMeal.isGlutenFree) {
          return false;
        }
        if (filtersKeyMap['lactose'] == true && !elementMeal.isLactoseFree) {
          return false;
        }
        if (filtersKeyMap['vegan'] == true && !elementMeal.isVegan) {
          return false;
        }
        if (filtersKeyMap['vegetarian'] == true && !elementMeal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> favoriteMeals = [];

  void toggleFavorites(String mealId) {
    final existingIndex =
        favoriteMeals.indexWhere((elementMeal) => elementMeal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(dummyMeals.firstWhere((elementMeal) => elementMeal.id == mealId));
      });

    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((element) => element.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals_Cook_Book',
      theme: ThemeData(
        // This is the theme of your application.

        //primarySwatch: Colors.pink,
        //colorScheme: const ColorScheme.light(secondary: Colors.amber,),
        //accentColor: Colors.amber,//accentColor: this property is deprecated
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Rale-way',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // titleLarge: const TextStyle(
              //   fontSize: 20,
              //   fontFamily: 'RobotoCondensed',
              //   fontWeight: FontWeight.bold,
              // ),
            ),
      ),
      //home: const CategoriesScreen(),
      initialRoute: '/',
      //default is this '/'
      debugShowCheckedModeBanner: false,

      routes: {
        //'/': (context) => const TabsScreen(),
        '/': (context) =>
            BottomNavigationBarScreen(favoriteMeals: favoriteMeals),
        //TabsScreen.routeName : (context) => const TabsScreen(),// no effects on screen
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorites: toggleFavorites, isMealFavorite: isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              filtersKeyMap: filtersKeyMap,
              saveFilters: setFilters,
            ),
      },
      // onGenerateRoute is used when byChance a routeName is missing then
      // this below conditions are used to generate HomePage or any
      // desirable page dynamically
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/meal-detail-screen'){
      //     return MaterialPageRoute(builder: (context) => differentPage,);
      //   }else if (settings.name == '/something-else'){
      //     return MaterialPageRoute(builder: (context) => differentPage,);
      //   }else
      //   return MaterialPageRoute(builder: (context) => MealDetailScreen(),);
      // },
      ///onUnknownRoute is used when we want user to show at-least something on screen
      ///if by any mistake apps crashed due to page/page name missing in routesName
      ///then users see page like Error404 page.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
    );
  }
}
