import 'package:connect/constants.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  Set<int> _selectedItems = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Interest'),
      ),
      backgroundColor: colorSecondary,
      body: Column(children: <Widget>[
        Text('The number of elements selected $_selectedItems'),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => setState(() {
                    if (_selectedItems.contains(index)) {
                      _selectedItems.remove(index);
                    } else {
                      _selectedItems.add(index);
                    }
                  }),
                  child: Card(
                      elevation: 0,
                      color: _selectedItems.contains(index) ? colorPrimary :Colors.black12,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      child:
                          Center(child: Text(interestSet.elementAt(index)))));
            },
            itemCount: interestSet.length,
          ),
        )
      ]),
    );
  }
}
