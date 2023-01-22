import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: const Text(
              'Cooking-Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.amber,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTileMethod(Icons.restaurant, 'Meals', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTileMethod(Icons.settings, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }

  ListTile buildListTileMethod(
      IconData iconData, String stringTitle, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        stringTitle,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.w700, //w700 = bold
        ),
      ),
      onTap: tapHandler, //if i pass tapHandler() function with brackets
      // then i get this error !_debugLocked is not true & Assertion failed
      //to avoid this error must pass only pointer of function only &
      //must use circle () brackets with function Function. -->DataType like Function()
    );
  }
}
