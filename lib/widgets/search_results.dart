import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/list_card.dart';

class SearchResult extends StatelessWidget {
  // This widget recieves the input from the search text input.
  final searchText;
  SearchResult({this.searchText});
  @override
  Widget build(BuildContext context) {
    // A method from the provider is used to filter all launches by text from the search text input
    final filteredLaunches = Provider.of<LaunchProvider>(context).filterLaunches(searchText.toLowerCase());

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 40, top: 10),
        itemExtent: 130,
        itemCount: filteredLaunches.length,
        itemBuilder: (context, index) {
          return ListCard(filteredLaunches[index]);
        },
      ),
    );
  }
}
