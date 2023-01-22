import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail-screen';
  final void Function(String mealId) toggleFavorites;
  final bool Function(String id) isMealFavorite;

  const MealDetailScreen(
      {Key? key, required this.toggleFavorites, required this.isMealFavorite})
      : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  // late var mealIdOfModalRoute;

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   mealIdOfModalRoute = ModalRoute.of(context)!.settings.arguments as String;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final mealIdOfModalRoute =
        ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere(
        (elementOfDummyMeal) => elementOfDummyMeal.id == mealIdOfModalRoute);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        // actions: [
        //   FloatingActionButton(
        //     onPressed: () {
        //       setState(() {
        //         widget.toggleFavorites(mealIdOfModalRoute);
        //       });
        //     },
        //     child: Icon(widget.isFavorite(mealIdOfModalRoute)
        //         ? Icons.favorite
        //         : Icons.favorite_border),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitleContainerMethod('ingredients'),
            buildListContainerMethod(
              ListView.builder(
                //this line was child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.amber,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
              ),
            ),
            buildSectionTitleContainerMethod('steps'),
            buildListContainerMethod(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${index + 1}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider(thickness: 2),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(mealIdOfModalRoute),
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(6),
              ),
              label: const Text(
                'Delete this item',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // FloatingActionButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(mealIdOfModalRoute);
            //   },
            //   child: const Icon(Icons.delete),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(widget.isMealFavorite(mealIdOfModalRoute)
            ? Icons.favorite
            : Icons.favorite_border),
        onPressed: () {
          setState(() {
            widget.toggleFavorites(mealIdOfModalRoute);
          });
        },
      ),
    );
  }

  Container buildListContainerMethod(Widget childWidget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: Colors.grey, width: 3, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      height: 150,
      child: childWidget,
    );
  }

  Container buildSectionTitleContainerMethod(String dynamicText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        dynamicText,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
