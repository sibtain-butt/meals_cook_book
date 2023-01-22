import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final void Function(Map<String, bool> filterData) saveFilters;
  final Map<String, bool> filtersKeyMap;

  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.filtersKeyMap})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGlutenFree = false;
  var isVegetarian = false;
  var isVegan = false;
  var isLactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    isGlutenFree = widget.filtersKeyMap['gluten']!;
    isVegetarian = widget.filtersKeyMap['vegetarian']!;
    isVegan = widget.filtersKeyMap['vegan']!;
    isLactoseFree = widget.filtersKeyMap['lactose']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                setState(() {
                  final selectedFiltersSavedPosition = {
                    'gluten': isGlutenFree,
                    'lactose': isLactoseFree,
                    'vegan': isVegan,
                    'vegetarian': isVegetarian,
                  };
                  widget.saveFilters(selectedFiltersSavedPosition);
                });
              }),
        ],
        title: const Text('Filters'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text('Adjust your meal selections.'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTileMethod(
                  isGlutenFree,
                  'Gluten-Free',
                  'Only include gluten-free meals',
                  (valueNew) {
                    setState(() {
                      isGlutenFree = valueNew;
                    });
                  },
                ),
                buildSwitchListTileMethod(
                  isVegetarian,
                  'Vegetarian',
                  'Only include vegetarian meals',
                  (valueNew) {
                    setState(() {
                      isVegetarian = valueNew;
                    });
                  },
                ),
                buildSwitchListTileMethod(
                  isVegan,
                  'Vegan',
                  'Only include vegan meals',
                  (valueNew) {
                    setState(() {
                      isVegan = valueNew;
                    });
                  },
                ),
                buildSwitchListTileMethod(
                  isLactoseFree,
                  'Lactose-Free',
                  'Only include lactose-free meals',
                  (valueNew) {
                    setState(() {
                      isLactoseFree = valueNew;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTileMethod(
    var valueOfFilters,
    String titleOfSwitch,
    String subtitleOfSwitch,
    Function(dynamic) onChangedSwitchTapHandler,
    //i get error of expected Argument 1
    //but found 0 because my error was this line
    //Function onChangedSwitchTapHandler()
    //Function() onChangedSwitchTapHandler(dynamic)
    //good way of code is to show dataType like inside Function(dynamic)
    //and no need for ? null like Function(dynamic)?
    //and i cannot use this Function(valueNew) also
  ) {
    return SwitchListTile(
      value: valueOfFilters,
      title: Text(titleOfSwitch),
      subtitle: Text(subtitleOfSwitch),
      onChanged: onChangedSwitchTapHandler,
    );
  }
}
