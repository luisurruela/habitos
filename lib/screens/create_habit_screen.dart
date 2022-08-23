import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({Key? key}) : super(key: key);

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double _value = 1;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: AppTheme.backgroundGradient,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              _appBar(context),
              _primaryTitle('Add new habbit'),
              _primaryInput(context, 'Habit title'),
              _iconsColorsButtons(),
              const SizedBox(
                height: 30,
              ),
              _secondaryTitle('Stars'),
              const SizedBox(
                height: 10,
              ),
              _normalText(
                  'Define how many points your child will earn by completing this habit.'),
              const SizedBox(
                height: 30,
              ),
              const _sliderWidget(),
              _secondaryTitle('Frequency'),
              const SizedBox(
                height: 10,
              ),
              _normalText('How often would you like to do it?'),
              _normalText('On these days'),
              const SizedBox(
                height: 30,
              ),
              _secondaryTitle('Time'),
              _normalText('In wich time of the day would you like to do it?'),
              const SizedBox(
                height: 30,
              ),
              _secondaryTitle('Assign to'),
              _normalText('To whom do we assign the habit?'),
              const SizedBox(
                height: 50,
              ),
              _submitButton(context),
            ])),
      ),
    );
  }
}

class _sliderWidget extends StatefulWidget {
  const _sliderWidget({Key? key}) : super(key: key);

  @override
  State<_sliderWidget> createState() => __sliderWidgetState();
}

class __sliderWidgetState extends State<_sliderWidget> {
  double _value = 1;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10.0,
        trackShape: const RoundedRectSliderTrackShape(),
        activeTrackColor: Colors.purple.shade800,
        inactiveTrackColor: Colors.purple.shade100,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 14.0,
          pressedElevation: 8.0,
        ),
        thumbColor: Colors.pinkAccent,
        overlayColor: Colors.pink.withOpacity(0.2),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.pinkAccent,
        inactiveTickMarkColor: Colors.white,
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.black,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      child: Slider(
          divisions: 100,
          value: _value,
          label: _value.round().toString(),
          min: 0.0,
          max: 100.0,
          onChanged: (value) {
            _value = value;
            setState(() {});
          }),
    );
  }
}

Widget _submitButton(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.85,
    height: 48,
    child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(218, 240, 75, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
        onPressed: null,
        child: const Text(
          'Login',
          style: TextStyle(color: Color.fromRGBO(12, 8, 40, 1)),
        )),
  );
}

Widget _iconsColorsButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      children: [
        _roundedButton(
            Icons.import_contacts_rounded, 'Icon', const Color(0xFFB2A9E9)),
        const SizedBox(
          width: 10,
        ),
        _roundedButton(Icons.circle, 'Color', const Color(0xFF8BE763)),
      ],
    ),
  );
}

Widget _roundedButton(IconData icon, String text, Color color) {
  return SizedBox(
    height: 40,
    width: 100,
    child: ElevatedButton(
      onPressed: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ]),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all<Color>(AppTheme.darkBlue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    ),
  );
}

Widget _primaryInput(BuildContext context, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Form(
        child: TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8B7EDF), width: 2.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.tertiary, width: 2.0),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
          floatingLabelStyle: const TextStyle(
              color: AppTheme.tertiary, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: AppTheme.primary),
    )),
  );
}

Widget _primaryTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTheme.h1,
        textAlign: TextAlign.end,
      ),
    ),
  );
}

Widget _secondaryTitle(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTheme.h2,
        textAlign: TextAlign.end,
      ),
    ),
  );
}

Widget _normalText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: AppTheme.lightPurple),
      ),
    ),
  );
}

Widget _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        )),
  );
}
