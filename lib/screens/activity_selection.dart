import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../components/appbars.dart';
import '../components/styles.dart';
import '../functions/user_service.dart';

class ActivitySelection extends StatefulWidget {
  const ActivitySelection({Key? key}) : super(key: key);

  @override
  _ActivitySelectionState createState() => _ActivitySelectionState();
}

class _ActivitySelectionState extends State<ActivitySelection> {
  DateTime _selectedTime = DateTime.now();
  int _selectedActivity = 0;
  final _promptController = TextEditingController();

  Widget _drawActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          chooseActivity,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 220,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activitySet.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedActivity = index;
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: Image.asset(activityIcons[index]).image),
                        border: Border.all(
                          color: _selectedActivity == index ? Colors.blue : Colors.black,
                          style: BorderStyle.solid,
                          width: 3,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(activitySet.elementAt(index)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _drawPrompt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          promptTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _promptController,
          maxLength: 30,
        ),
      ],
    );
  }

  Widget _drawTimeSelection() {
    String _simpleTime = DateFormat.jm().format(_selectedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          freeUntilTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showTimePicker(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: colorPrimary),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              _simpleTime,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawNextBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          UserService.activitySelection(_selectedActivity, _promptController.text.trim(), _selectedTime, context);
        },
        child: Text(
          nextBtn.toUpperCase(),
          style: Styles.defaultBtnTxt(),
        ),
        style: Styles.defaultBtn(),
      ),
    );
  }

  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: _selectedTime,
            minimumDate: DateTime.now(),
            onDateTimeChanged: (value) {
              setState(() {
                _selectedTime = value;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar(activitySelectionTitle),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _drawActivities(),
                  const SizedBox(height: 30),
                  _drawPrompt(),
                  const SizedBox(height: 30),
                  _drawTimeSelection(),
                  Expanded(child: Container()),
                  _drawNextBtn(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
