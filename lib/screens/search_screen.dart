import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spacextracker/widgets/search_results.dart';

import '../constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String textInputNotEmpty;

  // Setting up a controller for the text input.
  final textInputController = TextEditingController();
  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Adding a listener on the text input controller.
    // For every input the state is set, to let the widget know that a re-render is necessary if something has changed.
    textInputController.addListener(() {
      setState(() {});
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                right: width > 1500
                    ? 50.w
                    : width > 500
                        ? 20.w
                        : 15,
                left: width > 1500
                    ? 50.w
                    : width > 500
                        ? 20.w
                        : 15,
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: colorWhite)),
              child: TextField(
                autofocus: true,
                controller: textInputController,
                style: TextStyle(
                  color: colorWhite,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorWhite,
                  ),
                  suffixIcon: textInputController.text.length > 0
                      ? IconButton(
                          onPressed: () {
                            textInputController.clear();
                          },
                          icon: Icon(Icons.cancel),
                          color: colorWhite,
                        )
                      : null,
                ),
              ),
            ),
            SearchResult(searchText: textInputController.text)
          ],
        ),
      ),
    );
  }
}
