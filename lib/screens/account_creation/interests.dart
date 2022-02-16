import 'package:flutter/material.dart';

import '../../components/styles.dart';
import '../../constants.dart';
import '../../functions/user_service.dart';

class Interests extends StatefulWidget {
  const Interests({Key? key}) : super(key: key);

  @override
  _InterestsState createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  final List<String> _selectedItems = [];

  ChoiceChip _createChoiceChip(String choiceLabel, int categoryIndex) {
    return ChoiceChip(
      selectedColor: colorPrimary,
      labelStyle: TextStyle(
        color: _selectedItems.contains(choiceLabel) ? Colors.white : Colors.black,
        fontSize: 16,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      label: Text(choiceLabel),
      selected: _selectedItems.contains(choiceLabel),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
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

  Widget _drawInterestsAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      collapsedHeight: 70,
      expandedHeight: 70,
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
          start: 15,
          bottom: 2,
        ),
      ),
    );
  }

  Widget _drawInterestChips() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int categoryIndex) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        interestCategories.elementAt(categoryIndex),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: interestMap[interestCategories.elementAt(categoryIndex)]!
                            .map((category) => _createChoiceChip(category, categoryIndex))
                            .toList(),
                      )
                    ],
                  ),
                ),
            childCount: interestCategories.length),
      ),
    );
  }

  Widget _drawNextBtn() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(15),
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
                        noText.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UserService.setInterests(_selectedItems, context);
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        yesText.toUpperCase(),
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
            style: Styles.defaultBtnText(),
          ),
          style: Styles.defaultBtn(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _drawInterestsAppBar(),
          _drawInterestChips(),
          _drawNextBtn(),
        ],
      ),
    );
  }
}
