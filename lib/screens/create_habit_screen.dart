// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../widgets/star_shape.dart';

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

  Map<String, dynamic> group = {
    'morning': true,
    'afternoon': false,
    'night': false,
  };

  Map<String, dynamic> days = {
    'sunday': true,
    'monday': true,
    'tuesday': true,
    'wednesday': true,
    'thursday': true,
    'friday': true,
    'saturday': true,
  };

  Map<int, bool> week = {
    1: true,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
  };

  Map<int, bool> month = {1: true, 2: false, 3: false};

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
                      callback: updateFrecuency,
                      value: 'daily',
                    ),
                    _SecondaryButton(
                      title: 'Weekly',
                      isActive: frecuency['weekly'],
                      callback: updateFrecuency,
                      value: 'weekly',
                    ),
                    _SecondaryButton(
                      title: 'Monthly',
                      isActive: frecuency['monthly'],
                      callback: updateFrecuency,
                      value: 'monthly',
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
                _DaysWidget(callback: updateDailyDays, data: days),
              ],
              if (frecuency['weekly']) ...[
                _normalText('Repeat 1 day a week'),
                const SizedBox(
                  height: 20,
                ),
                _WeekWidget(
                  callback: updateWeeklyDays,
                  data: week,
                ),
              ],
              if (frecuency['monthly']) ...[
                _normalText('Repeat 1 day a month'),
                const SizedBox(
                  height: 20,
                ),
                _MonthsWidget(
                  data: month,
                  callback: updateMonthlyDays,
                ),
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
                      isActive: group['morning'],
                      callback: updateGroup,
                      value: 'morning',
                    ),
                    _SecondaryButton(
                      title: 'Afternoon',
                      isActive: group['afternoon'],
                      callback: updateGroup,
                      value: 'afternoon',
                    ),
                    _SecondaryButton(
                      title: 'Night',
                      isActive: group['night'],
                      callback: updateGroup,
                      value: 'night',
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

  updateFrecuency(String index) {
    resetFrecuency();
    frecuency[index] = true;
    setState(() {});
  }

  updateGroup(String index) {
    resetGroup();
    group[index] = true;
    setState(() {});
  }

  resetGroup() {
    group = {
      'morning': false,
      'afternoon': false,
      'night': false,
    };
    setState(() {});
  }

  resetFrecuency() {
    frecuency = {
      'daily': false,
      'weekly': false,
      'monthly': false,
    };
  }

  updateDailyDays(String day) {
    days[day] = !days[day];
    setState(() {});
  }

  updateWeeklyDays(String days) {
    final day = int.parse(days);
    resetWeeklyDays();
    week.update(day, (value) => true);
    setState(() {});
  }

  updateMonthlyDays(String days) {
    final day = int.parse(days);
    resetMonthlyDays();
    month.update(day, (value) => true);
    setState(() {});
  }

  resetMonthlyDays() {
    month = {
      1: false,
      2: false,
      3: false,
    };
    setState(() {});
  }

  resetWeeklyDays() {
    week = {
      1: false,
      2: false,
      3: false,
      4: false,
      5: false,
      6: false,
      7: false,
    };
  }
}

class _DaysWidget extends StatelessWidget {
  final Function callback;
  Map data;
  _DaysWidget({Key? key, required this.callback, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(
            title: 'S',
            isActive: data['sunday'],
            callback: callback,
            data: data,
            value: 'sunday',
          ),
          _CircleButton(
            title: 'M',
            isActive: data['monday'],
            callback: callback,
            data: data,
            value: 'monday',
          ),
          _CircleButton(
            title: 'T',
            isActive: data['tuesday'],
            callback: callback,
            data: data,
            value: 'tuesday',
          ),
          _CircleButton(
            title: 'W',
            isActive: data['wednesday'],
            callback: callback,
            data: data,
            value: 'wednesday',
          ),
          _CircleButton(
            title: 'T',
            isActive: data['thursday'],
            callback: callback,
            data: data,
            value: 'thursday',
          ),
          _CircleButton(
            title: 'F',
            isActive: data['friday'],
            callback: callback,
            data: data,
            value: 'friday',
          ),
          _CircleButton(
            title: 'S',
            isActive: data['saturday'],
            callback: callback,
            data: data,
            value: 'saturday',
          ),
        ],
      ),
    );
  }
}

class _WeekWidget extends StatelessWidget {
  final Function callback;
  final Map data;
  const _WeekWidget({Key? key, required this.callback, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(
            title: '1',
            isActive: data[1],
            value: '1',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '2',
            isActive: data[2],
            value: '2',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '3',
            isActive: data[3],
            value: '3',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '4',
            isActive: data[4],
            value: '4',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '5',
            isActive: data[5],
            value: '5',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '6',
            isActive: data[6],
            value: '6',
            callback: callback,
            data: data,
          ),
          _CircleButton(
            title: '7',
            isActive: data[7],
            value: '7',
            callback: callback,
            data: data,
          ),
        ],
      ),
    );
  }
}

class _MonthsWidget extends StatelessWidget {
  final Map data;
  final Function callback;
  const _MonthsWidget({Key? key, required this.data, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SecondaryButton(
            title: '1',
            isActive: data[1],
            callback: callback,
            value: '1',
          ),
          _SecondaryButton(
            title: '2',
            isActive: data[2],
            callback: callback,
            value: '2',
          ),
          _SecondaryButton(
            title: '3',
            isActive: data[3],
            callback: callback,
            value: '3',
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton(
      {Key? key,
      required this.title,
      required this.isActive,
      required this.callback,
      required this.data,
      required this.value})
      : super(key: key);
  final String title;
  final bool isActive;
  final Function callback;
  final Map data;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: ElevatedButton(
        onPressed: () => callback(value),
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
  final String title;
  final bool isActive;
  final Function callback;
  final String value;
  const _SecondaryButton(
      {Key? key,
      required this.title,
      required this.isActive,
      required this.callback,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .28,
      child: ElevatedButton(
        onPressed: () => callback(value),
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
        child: SfSlider(
          min: 1,
          max: 100,
          value: _value.ceil(),
          activeColor: AppTheme.secondary,
          inactiveColor: const Color(0xFF6553D4),
          thumbShape: StarShape(),
          enableTooltip: true,
          tooltipTextFormatterCallback:
              (dynamic actualValue, String formattedText) {
            return '+$formattedText';
          },
          tooltipShape: const SfRectangularTooltipShape(),
          interval: 1,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ));
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
