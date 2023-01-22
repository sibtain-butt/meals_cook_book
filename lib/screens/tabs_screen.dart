///===============this page is for practice only=============///
///==========to check how DefaultTabController works=========///
///=========i added this because i need to check that========///
///===========i can add both BottomNavigationBar=============///
///======================== -&- =============================///
///================ DefaultTabController ====================///

// import 'package:flutter/material.dart';
//
// import '../screens/categories_screen.dart';
// import '../screens/favorite_screen.dart';
//
// class TabsScreen extends StatefulWidget {
//
//   static const routeName = '/tabs-screen';
//   const TabsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Meals'),
//           bottom: const TabBar(
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(Icons.category),
//                 child: Text('Categories'),
//               ),
//               Tab(
//                 icon: Icon(Icons.favorite),
//                 child: Text('Favorites'),
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: <Widget>[
//             CategoriesScreen(),
//             FavoriteScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
