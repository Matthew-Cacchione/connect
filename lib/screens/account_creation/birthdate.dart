import 'package:connect/components/appbar.dart';
import 'package:connect/components/buttons.dart';
import 'package:connect/constants.dart';
import 'package:flutter/material.dart';

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

  Widget drawBirthdatePrompt() {
    return const Text(
      birthdatePrompt,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget drawDisplayBirthdate() {
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

  Widget drawNextBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          nextBtn.toUpperCase(),
          style: btnTextStyle,
        ),
        style: btnStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(birthdateTitle),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            drawBirthdatePrompt(),
            const SizedBox(height: 5),
            drawDisplayBirthdate(),
            Expanded(child: Container()),
            drawNextBtn(),
          ],
        ),
      ),
    );
  }
}
