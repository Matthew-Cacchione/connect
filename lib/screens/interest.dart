import 'package:connect/constants.dart';
import 'package:connect/functions/authentication.dart';
import 'package:connect/functions/user_service.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final List<String> _selectedItems = [];

  ChoiceChip createChoiceChip(String choiceLabel, int categoryIndex) {
    return ChoiceChip(
        selectedColor: Colors.purple,
        labelStyle: TextStyle(
            color: _selectedItems.contains(choiceLabel)
                ? Colors.white
                : Colors.black),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: Text(choiceLabel),
        selected: _selectedItems.contains(choiceLabel),
        onSelected: (selected) {
          setState(() {
            if (_selectedItems.length < 5) {
              if (_selectedItems.contains(choiceLabel)) {
                _selectedItems.remove(choiceLabel);
              } else {
                _selectedItems.add(choiceLabel);
              }
            } else {
              showErrorSnackBar("Please select 5 items max", context);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: CustomScrollView(slivers: [
          SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              expandedHeight: 180,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text(
                              'What are your Interests?',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              'Please Select Up to 5 Interests.',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
                            ))
                      ]),
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 20,
                    bottom: 5,
                  ),
                  background: Image.network(
                    "https://images.unsplash.com/photo-1614851099507-f1a93001d984?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                    fit: BoxFit.fill,
                  ))),
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int categoryIndex) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    interestCategories.elementAt(categoryIndex),
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: interestMap[interestCategories
                                          .elementAt(categoryIndex)]!
                                      .map((category) => createChoiceChip(
                                          category, categoryIndex))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                      childCount: interestCategories.length))),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  setInterestCurrentUser(_selectedItems, context);
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo.shade700,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
              ),
            ),
          )
        ]));
  }
}
