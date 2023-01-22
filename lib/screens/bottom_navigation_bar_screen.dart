import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';

import '../widgets/main_drawer.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const BottomNavigationBarScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late List<Map<String, Object>> pages;

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      {'page': const CategoriesScreen(), 'title': 'Meals Cook Book'},
      {
        'page': FavoriteScreen(favoriteMeals: widget.favoriteMeals),
        'title': 'Favorite Meals'
      },
      //{''}
    ];
    super.initState();
  }

  // final List<Widget> _pages = [
  //   const CategoriesScreen(),
  //   const FavoriteScreen(),
  // ];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pages[_selectedPageIndex]['title']}'),
      ),
      //body: _pages[_selectPageIndex], for List<Widget> only
      body: pages[_selectedPageIndex]['page'] as Widget,
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Category',
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.favorite,
            ),
          )
        ],
      ),
    );
  }
}
