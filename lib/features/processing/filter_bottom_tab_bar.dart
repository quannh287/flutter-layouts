import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:layouts/utils/color_filter.dart';

class FilterBottomTabBar extends StatefulWidget {
  const FilterBottomTabBar({Key? key}) : super(key: key);

  @override
  State<FilterBottomTabBar> createState() => _FilterBottomTabBarState();
}

class _FilterBottomTabBarState extends State<FilterBottomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          const Text("List filters"),
          Expanded(
            child: ListView.builder(
              itemCount: ColorFilterMatrix.values.length,
              itemBuilder: (BuildContext context, int index) {
                return _filterItem(ColorFilterMatrix.values[index].name);
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterItem(String itemName) {
    return Center(
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              itemName.toCapitalize(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
