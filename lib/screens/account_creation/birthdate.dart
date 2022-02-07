import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../components/styles.dart';
import '../../constants.dart';
import '../../functions/user_service.dart';

class Birthdate extends StatefulWidget {
  const Birthdate({Key? key}) : super(key: key);

  @override
  _BirthdateState createState() => _BirthdateState();
}

class _BirthdateState extends State<Birthdate> {
  DateTime currentDate = DateTime.now();
  DateTime userBirthdate = DateTime.now();

  Future<void> _selectBirthdate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: currentDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        userBirthdate = selectedDate;
      });
    }
  }

  Widget _drawBirthdatePrompt() {
    return const Text(
      birthdatePrompt,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget _drawDisplayBirthdate() {
    String simpleBirthdate =
        '${userBirthdate.year.toString()} - ${userBirthdate.month.toString().padLeft(2, '0')} - ${userBirthdate.day.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () => _selectBirthdate(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: colorPrimary),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          simpleBirthdate,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget _drawNextBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          UserService.setBirthdate(userBirthdate, context);
        },
        child: Text(
          nextBtn.toUpperCase(),
          style: Styles.defaultBtnTxt(),
        ),
        style: Styles.defaultBtn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar(birthdateTitle),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            _drawBirthdatePrompt(),
            const SizedBox(height: 5),
            _drawDisplayBirthdate(),
            Expanded(child: Container()),
            _drawNextBtn(),
          ],
        ),
      ),
    );
  }
}
