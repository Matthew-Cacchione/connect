import 'package:connect/constants.dart';
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
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              pinned: true,
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
                            )),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Please Select Up to 5 Interests.',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.white),
                            ))
                      ]),
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 20.0,
                    bottom: 5.0,
                  ),
                  background: Image.network(
                    "https://images.unsplash.com/photo-1614851099507-f1a93001d984?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                    fit: BoxFit.fill,
                  ))),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int categoryIndex) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16, left: 8),
                                child: Text(
                                  interestCategories.elementAt(categoryIndex),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                          height: 45,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children: interestMap[
                                                      interestCategories
                                                          .elementAt(
                                                              categoryIndex)]!
                                                  .map((item) => Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 8,
                                                              right: 8),
                                                      child: ChoiceChip(
                                                        label: Text(item),
                                                        selected: true,
                                                      )))
                                                  .toList())))
                                ],
                              )
                            ]),
                    childCount: interestMap.length)),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 20, left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
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
