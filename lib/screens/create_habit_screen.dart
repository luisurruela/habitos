// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({Key? key}) : super(key: key);

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  Map<String, dynamic> frecuency = {
    'daily': true,
    'weekly': false,
    'monthly': false,
  };

  Map<String, dynamic> time = {
    'morning': true,
    'afternoon': false,
    'night': false,
  };

  bool morning = true;
  bool afternoon = false;
  bool night = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
              const _SliderWidget(),
              const SizedBox(
                height: 30,
              ),
              _secondaryTitle('Frequency'),
              const SizedBox(
                height: 10,
              ),
              _normalText('How often would you like to do it?'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SecondaryButton(
                      title: 'Daily',
                      isActive: frecuency['daily'],
                      onPress: activeDailyButton,
                    ),
                    _SecondaryButton(
                      title: 'Weekly',
                      isActive: frecuency['weekly'],
                      onPress: activeWeeklyButton,
                    ),
                    _SecondaryButton(
                      title: 'Monthly',
                      isActive: frecuency['monthly'],
                      onPress: activeMonthlyButton,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (frecuency['daily']) ...[
                _normalText('On these days'),
                const SizedBox(
                  height: 20,
                ),
                const _DaysWidget(),
              ],
              if (frecuency['weekly']) ...[
                _normalText('Repeat 1 day a week'),
                const SizedBox(
                  height: 20,
                ),
                const _WeekWidget(),
              ],
              if (frecuency['monthly']) ...[
                _normalText('Repeat 1 day a month'),
                const SizedBox(
                  height: 20,
                ),
                _monthsWidget(context),
              ],
              const SizedBox(
                height: 50,
              ),
              _secondaryTitle('Time'),
              _normalText('In which time of the day would you like to do it?'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SecondaryButton(
                      title: 'Morning',
                      isActive: time['morning'],
                      onPress: activeMorningButton,
                    ),
                    _SecondaryButton(
                      title: 'Afternoon',
                      isActive: time['afternoon'],
                      onPress: activeAfternoonButton,
                    ),
                    _SecondaryButton(
                      title: 'Night',
                      isActive: time['night'],
                      onPress: activeNightButton,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              _secondaryTitle('Assign to'),
              _normalText('To whom do we assign the habit?'),
              const SizedBox(
                height: 80,
              ),
              _submitButton(context),
              const SizedBox(
                height: 50,
              )
            ])),
      ),
    );
  }

  void activeDailyButton() {
    frecuency = {
      'daily': true,
      'weekly': false,
      'monthly': false,
    };
    setState(() {});
  }

  void activeWeeklyButton() {
    frecuency = {
      'daily': false,
      'weekly': true,
      'monthly': false,
    };
    setState(() {});
  }

  void activeMonthlyButton() {
    frecuency = {
      'daily': false,
      'weekly': false,
      'monthly': true,
    };
    setState(() {});
  }

  void activeMorningButton() {
    time = {
      'morning': true,
      'afternoon': false,
      'night': false,
    };
    setState(() {});
  }

  void activeAfternoonButton() {
    time = {
      'morning': false,
      'afternoon': true,
      'night': false,
    };
    setState(() {});
  }

  void activeNightButton() {
    time = {
      'morning': false,
      'afternoon': false,
      'night': true,
    };
    setState(() {});
  }
}

class _DaysWidget extends StatefulWidget {
  const _DaysWidget({Key? key}) : super(key: key);

  @override
  State<_DaysWidget> createState() => __DaysWidgetState();
}

class __DaysWidgetState extends State<_DaysWidget> {
  Map<String, dynamic> days = {
    'sunday': true,
    'monday': true,
    'tuesday': true,
    'wednesday': true,
    'thursday': true,
    'friday': true,
    'saturday': true,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(
            title: 'S',
            isActive: days['sunday'],
            onPress: toggleSunday,
          ),
          _CircleButton(
            title: 'M',
            isActive: days['monday'],
            onPress: toggleMonday,
          ),
          _CircleButton(
            title: 'T',
            isActive: days['tuesday'],
            onPress: toggleTuesday,
          ),
          _CircleButton(
            title: 'W',
            isActive: days['wednesday'],
            onPress: toggleWednesday,
          ),
          _CircleButton(
            title: 'T',
            isActive: days['thursday'],
            onPress: toggleThursday,
          ),
          _CircleButton(
            title: 'F',
            isActive: days['friday'],
            onPress: toggleFriday,
          ),
          _CircleButton(
            title: 'S',
            isActive: days['saturday'],
            onPress: toggleSaturday,
          ),
        ],
      ),
    );
  }

  void toggleSunday() {
    days['sunday'] = !days['sunday'];
    setState(() {});
  }

  void toggleMonday() {
    days['monday'] = !days['monday'];
    setState(() {});
  }

  void toggleTuesday() {
    days['tuesday'] = !days['tuesday'];
    setState(() {});
  }

  void toggleWednesday() {
    days['wednesday'] = !days['wednesday'];
    setState(() {});
  }

  void toggleThursday() {
    days['thursday'] = !days['thursday'];
    setState(() {});
  }

  void toggleFriday() {
    days['friday'] = !days['friday'];
    setState(() {});
  }

  void toggleSaturday() {
    days['saturday'] = !days['saturday'];
    setState(() {});
  }
}

class _WeekWidget extends StatefulWidget {
  const _WeekWidget({Key? key}) : super(key: key);

  @override
  State<_WeekWidget> createState() => __WeekWidgetState();
}

class __WeekWidgetState extends State<_WeekWidget> {
  Map<int, dynamic> days = {
    1: true,
    2: true,
    3: true,
    4: true,
    5: true,
    6: true,
    7: true,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(
            title: '1',
            isActive: days[1],
            onPress: toggleOne,
          ),
          _CircleButton(
            title: '2',
            isActive: days[2],
            onPress: toggleTwo,
          ),
          _CircleButton(
            title: '3',
            isActive: days[3],
            onPress: toggleThree,
          ),
          _CircleButton(
            title: '4',
            isActive: days[4],
            onPress: toggleFour,
          ),
          _CircleButton(
            title: '5',
            isActive: days[5],
            onPress: toggleFive,
          ),
          _CircleButton(
            title: '6',
            isActive: days[6],
            onPress: toggleSix,
          ),
          _CircleButton(
            title: '7',
            isActive: days[7],
            onPress: toggleSeven,
          ),
        ],
      ),
    );
  }

  void toggleOne() {
    days[1] = !days[1];
    setState(() {});
  }

  void toggleTwo() {
    days[2] = !days[2];
    setState(() {});
  }

  void toggleThree() {
    days[3] = !days[3];
    setState(() {});
  }

  void toggleFour() {
    days[4] = !days[4];
    setState(() {});
  }

  void toggleFive() {
    days[5] = !days[5];
    setState(() {});
  }

  void toggleSix() {
    days[6] = !days[6];
    setState(() {});
  }

  void toggleSeven() {
    days[7] = !days[7];
    setState(() {});
  }
}

Widget _monthsWidget(BuildContext context) {
  void monthlySelection() {}
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SecondaryButton(
          title: '1',
          isActive: true,
          onPress: monthlySelection,
        ),
        _SecondaryButton(
          title: '2',
          isActive: false,
          onPress: monthlySelection,
        ),
        _SecondaryButton(
          title: '3',
          isActive: false,
          onPress: monthlySelection,
        ),
      ],
    ),
  );
}

class _CircleButton extends StatelessWidget {
  _CircleButton(
      {Key? key, required this.title, required this.isActive, this.onPress})
      : super(key: key);
  final String title;
  final bool isActive;
  Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: ElevatedButton(
        onPressed: onPress,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
            )),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.zero, // <-- had to set padding to zero
            ),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(
                isActive ? AppTheme.secondary : AppTheme.darkBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  _SecondaryButton(
      {Key? key, required this.title, required this.isActive, this.onPress})
      : super(key: key);
  final String title;
  final bool isActive;
  void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .28,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(title),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(
                isActive ? AppTheme.secondary : AppTheme.darkBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
      ),
    );
  }
}

class _SliderWidget extends StatefulWidget {
  const _SliderWidget({Key? key}) : super(key: key);

  @override
  State<_SliderWidget> createState() => __SliderWidgetState();
}

class __SliderWidgetState extends State<_SliderWidget> {
  double _value = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4.0,
          trackShape: const RoundedRectSliderTrackShape(),
          activeTrackColor: AppTheme.lightPurple,
          inactiveTrackColor: AppTheme.lightPurple,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 12.0,
            pressedElevation: 0,
          ),
          thumbColor: AppTheme.starYellow,
          tickMarkShape: const RoundSliderTickMarkShape(),
          inactiveTickMarkColor: AppTheme.starYellow,
          valueIndicatorColor: AppTheme.lightPurple,
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
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
      ),
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
