import 'package:connect/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final Set<int> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(slivers: [
        SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'What are your Interests?',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.apply(color: Colors.white),
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Please Select Up to 5 Interests.',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.apply(color: Colors.white),
                        )
                      )
                    ]),
                titlePadding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                  bottom: 5.0,
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      "https://images.unsplash.com/photo-1614851099507-f1a93001d984?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                      fit: BoxFit.fill,
                    ),
                  ],
                ))),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => Text(
                      interestSet.elementAt(index),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                childCount: interestMap.length))
      ])
      //     Column(children: <Widget>[
      // Expanded(
      // child: GridView.builder(
      // padding: const EdgeInsets.all(10),
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      // crossAxisCount: 2,
      // childAspectRatio: 1.75,
      // crossAxisSpacing: 5,
      // mainAxisSpacing: 5),
      // itemBuilder: (BuildContext context, int index) {
      // return GestureDetector(
      // onTap: () =>
      // setState(() {
      // if (_selectedItems.contains(index)) {
      // _selectedItems.remove(index);
      // } else {
      // _selectedItems.add(index);
      // }
      // }),
      // child: Card(
      // elevation: 0,
      // color: _selectedItems.contains(index)
      // ? colorPrimary
      //     : Colors.black12,
      // shape: RoundedRectangleBorder(
      // side: BorderSide.none,
      // borderRadius: BorderRadius.circular(10)),
      // child: Center(
      // child: Text(
      // interestSet.elementAt(index),
      // style: TextStyle(
      // fontWeight: FontWeight.bold,
      // color: _selectedItems.contains(index)
      // ? Colors.white
      //     : Colors.black),
      // ))));
      // },
      // itemCount: interestSet.length,
      // ),
      // ),
      // Material(
      // elevation: 0,
      // color: Colors.white,
      // // color: colorPrimary,
      // child: Container(
      // margin: const EdgeInsets.all(20),
      // width: double.infinity,
      // child: ElevatedButton(
      // onPressed: () {
      // ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(
      // content: Text(
      // 'The items selected: $_selectedItems',
      // textAlign: TextAlign.center,
      // ),
      // ),
      // );
      // },
      // child: const Text('Submit'),
      // style: ElevatedButton.styleFrom(
      // primary: colorPrimary,
      // padding: const EdgeInsets.all(20),
      // shape: RoundedRectangleBorder(
      // borderRadius: BorderRadius.circular(10),
      // ),
      // ))),
      // )
      // ]
      // )
      ,
    );
  }
}
