import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

Widget buildSearchBar(BuildContext context) {
  // final searchProvider = Provider.of<SearchProvider>(context);

  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextField(
      onEditingComplete: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute<void>(
        //     builder: (_) => SearchPage(
        //       initialTerm: searchProvider.getSearchTerm(),
        //     ),
        //   ),
        // );
      },
      keyboardType: TextInputType.text,
      onChanged: (_) {
        //searchProvider.updateSearchTerm(_);
      },
      decoration: InputDecoration(
        hintText: "Search for products",
        hintStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.bold,
        ),
        fillColor: Colors.grey[200],
        filled: true,
        // prefixIcon: Icon(CarbonIcons.search),
        suffixIcon: IconButton(
          icon: Container(
            height: 35.0,
            width: 35.0,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: Icon(
              CarbonIcons.search,
              color: Colors.blue[900],
              size: 20.0,
            ),
          ),
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute<void>(
            //     builder: (_) => SearchPage(
            //       initialTerm: searchProvider.getSearchTerm(),
            //     ),
            //   ),
            // );
          },
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
