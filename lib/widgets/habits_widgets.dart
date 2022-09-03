import 'package:flutter/material.dart';
import 'package:habitos/widgets/habits_icons.dart';
import 'package:habitos/widgets/star_shape.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../theme/theme.dart';

// ignore: must_be_immutable
class DaysWidget extends StatelessWidget {
  final Function callback;
  Map data;
  DaysWidget({Key? key, required this.callback, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            title: 'S',
            isActive: data['sunday'],
            callback: callback,
            data: data,
            value: 'sunday',
          ),
          CircleButton(
            title: 'M',
            isActive: data['monday'],
            callback: callback,
            data: data,
            value: 'monday',
          ),
          CircleButton(
            title: 'T',
            isActive: data['tuesday'],
            callback: callback,
            data: data,
            value: 'tuesday',
          ),
          CircleButton(
            title: 'W',
            isActive: data['wednesday'],
            callback: callback,
            data: data,
            value: 'wednesday',
          ),
          CircleButton(
            title: 'T',
            isActive: data['thursday'],
            callback: callback,
            data: data,
            value: 'thursday',
          ),
          CircleButton(
            title: 'F',
            isActive: data['friday'],
            callback: callback,
            data: data,
            value: 'friday',
          ),
          CircleButton(
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

class WeekWidget extends StatelessWidget {
  final Function callback;
  final Map data;
  const WeekWidget({Key? key, required this.callback, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecondaryButton(
            title: '1',
            isActive: data[1],
            value: '1',
            callback: callback,
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '2',
            isActive: data[2],
            value: '2',
            callback: callback,
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '3',
            isActive: data[3],
            value: '3',
            callback: callback,
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '4',
            isActive: data[4],
            value: '4',
            callback: callback,
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '5',
            isActive: data[5],
            value: '5',
            callback: callback,
            elementsCount: data.length,
          )
        ],
      ),
    );
  }
}

class MonthsWidget extends StatelessWidget {
  final Map data;
  final Function callback;
  const MonthsWidget({Key? key, required this.data, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecondaryButton(
            title: '1',
            isActive: data[1],
            callback: callback,
            value: '1',
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '2',
            isActive: data[2],
            callback: callback,
            value: '2',
            elementsCount: data.length,
          ),
          SecondaryButton(
            title: '3',
            isActive: data[3],
            callback: callback,
            value: '3',
            elementsCount: data.length,
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton(
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

class SecondaryButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function callback;
  final String value;
  final int elementsCount;
  const SecondaryButton(
      {Key? key,
      required this.title,
      required this.isActive,
      required this.callback,
      required this.value,
      required this.elementsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: elementsCount > 3
          ? (width / elementsCount) * 0.82
          : (width / elementsCount) * 0.86,
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

class SliderWidget extends StatelessWidget {
  final double currentValue;
  final Function callback;
  const SliderWidget(
      {Key? key, required this.currentValue, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SfSlider(
          min: 1,
          max: 100,
          value: currentValue.ceil(),
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
          onChanged: (value) => callback(value),
        ));
  }
}

Widget submitButton(BuildContext context) {
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

class IconsColorsButtons extends StatelessWidget {
  final Function callback;
  const IconsColorsButtons({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          RoundedButton(
            icon: Icons.import_contacts_rounded,
            text: 'Icon',
            color: const Color(0xFFB2A9E9),
            callback: showIconPopup,
          ),
          const SizedBox(
            width: 10,
          ),
          RoundedButton(
            icon: Icons.circle,
            text: 'Color',
            color: const Color(0xFF8BE763),
            callback: showColorPopup,
          ),
        ],
      ),
    );
  }

  showIconPopup(context) {
    final List iconsList = icons;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              const Text(
                'Choose an icon',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color(0xFF0C0828),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: GridView.count(
                      crossAxisCount: 6,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: iconsList
                          .map((element) => IconButton(
                              onPressed: () =>
                                  callback(element['name'], 'icon'),
                              icon: Icon(
                                element['icon'],
                                color: Colors.white,
                              )))
                          .toList()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showColorPopup(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              const Text(
                'Pick icon color',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color(0xFF0C0828),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  width: double.maxFinite,
                  height: 150,
                  child: GridView.count(
                      crossAxisCount: 3,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 40.0,
                      crossAxisSpacing: 70.0,
                      children: [
                        IconButton(
                          onPressed: () => callback('0xFF21D5DF', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFF21D5DF),
                          ),
                        ),
                        IconButton(
                          onPressed: () => callback('0xFF8BE763', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFF8BE763),
                          ),
                        ),
                        IconButton(
                          onPressed: () => callback('0xFFFF6668', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFFFF6668),
                          ),
                        ),
                        IconButton(
                          onPressed: () => callback('0xFFFF82CD', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFFFF82CD),
                          ),
                        ),
                        IconButton(
                          onPressed: () => callback('0xFFFEB701', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFFFEB701),
                          ),
                        ),
                        IconButton(
                          onPressed: () => callback('0xFFFF8552', 'color'),
                          highlightColor:
                              const Color(0xFF3220A1).withOpacity(0.9),
                          splashColor: const Color(0xFF3220A1).withOpacity(1),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFFFF8552),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Function callback;
  const RoundedButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.color,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: ElevatedButton(
        onPressed: () => callback(context),
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
}

class PrimaryInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function callback;
  const PrimaryInput(
      {Key? key,
      required this.label,
      required this.controller,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          child: TextFormField(
        onChanged: (value) => callback(),
        controller: controller,
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
}

Widget primaryTitle(String text) {
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

Widget secondaryTitle(String text) {
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

Widget normalText(String text) {
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

Widget appBar(BuildContext context) {
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
