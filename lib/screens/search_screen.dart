import 'package:flutter/material.dart';
import 'package:spacextracker/widgets/search_results.dart';

import '../constants.dart';

// class SearchScreen extends StatelessWidget {
//   String textInputNotEmpty;

//   @override
//   Widget build(BuildContext context) {
//     String textInput = "";

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Search'),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(bottom: 25),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(20),
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: colorWhite)),
//                   child: TextField(
//                     onChanged: (text) {
//                       textInput = text;
//                       print(text);
//                     },
//                     style: TextStyle(color: colorWhite, decoration: TextDecoration.none),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: colorWhite,
//                         ),
//                         suffixIcon: textInput.length > 0 ? Icon(Icons.cancel) : null),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String textInputNotEmpty;
  final textInputController = TextEditingController();
  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              margin: EdgeInsets.all(20),
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
