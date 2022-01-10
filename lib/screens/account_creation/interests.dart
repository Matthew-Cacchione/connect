import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../constants.dart';
import '../../functions/user_service.dart';

class Interests extends StatefulWidget {
  const Interests({Key? key}) : super(key: key);

  @override
  _InterestsState createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  final List<String> _selectedItems = [];

  ChoiceChip createChoiceChip(String choiceLabel, int categoryIndex) {
    return ChoiceChip(
      selectedColor: colorSecondary,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      label: Text(choiceLabel),
      selected: _selectedItems.contains(choiceLabel),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onSelected: (selected) {
        setState(
          () {
            if (_selectedItems.contains(choiceLabel)) {
              _selectedItems.remove(choiceLabel);
            } else {
              _selectedItems.add(choiceLabel);
            }
          },
        );
      },
    );
  }

  Widget drawInterestsAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      collapsedHeight: 70,
      expandedHeight: 120,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: const Text(
                interestsTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                interestsSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsetsDirectional.only(
          start: 20,
          bottom: 5,
        ),
        background: Image.asset(
          'assets/images/interests_background.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget drawInterestChips() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int categoryIndex) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        interestCategories.elementAt(categoryIndex).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: interestMap[interestCategories.elementAt(categoryIndex)]!
                            .map((category) => createChoiceChip(category, categoryIndex))
                            .toList(),
                      )
                    ],
                  ),
                ),
            childCount: interestCategories.length),
      ),
    );
  }

  Widget drawNextBtn() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            if (_selectedItems.isEmpty) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: Text(
                    noInterests.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    noInterestsPrompt,
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        noTxt.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UserService.setInterests(_selectedItems, context);
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        yesTxt.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              UserService.setInterests(_selectedItems, context);
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          child: Text(
            nextBtn.toUpperCase(),
            style: Buttons.getTextStyle(),
          ),
          style: Buttons.getStyle(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          drawInterestsAppBar(),
          drawInterestChips(),
          drawNextBtn(),
        ],
      ),
    );
  }
}
