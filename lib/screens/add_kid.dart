import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitos/screens/home_screen.dart';
import '../theme/theme.dart';

class AddKidScreen extends StatefulWidget {
  const AddKidScreen({Key? key, required this.backButton}) : super(key: key);

  final bool backButton;

  @override
  State<AddKidScreen> createState() => _AddKidScreenState();
}

class _AddKidScreenState extends State<AddKidScreen> {
  DateTime? selectedDate;
  TextEditingController name = TextEditingController();
  TextEditingController currentDate = TextEditingController();
  bool buttonEnabled = false;
  final DateTime firstDate = DateTime(1947);
  final DateTime lastDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final _formKey = GlobalKey<FormState>();
  DateTime pickDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: AppTheme.backgroundGradient,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: widget.backButton
                      ? IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ))
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width * 0.9,
                  child: Column(
                    children: [
                      const Text(
                        'Setup your child profile',
                        style: AppTheme.fontTitleWhite,
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Please give us a little more information about your child',
                          style: AppTheme.fontSubTitleWhite,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Insert avatar widget
                      SizedBox(
                        child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: const Color(0xFF3220A1),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                      "assets/images/default_avatar.png"),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppTheme.tertiary,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                        ),
                                        onPressed: () => selectAvatar(context),
                                      ),
                                    )),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: width,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: name,
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white24, width: 2.0),
                                    ),
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.white70),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 2.0),
                                    ),
                                    labelText: "Child's Name",
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      buttonEnabled = true;
                                      setState(() {});
                                    } else {
                                      buttonEnabled = false;
                                      setState(() {});
                                    }
                                  },
                                  validator: nameValidate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      buttonEnabled = true;
                                      setState(() {});
                                    } else {
                                      buttonEnabled = false;
                                      setState(() {});
                                    }
                                  },
                                  keyboardType: TextInputType.datetime,
                                  style: const TextStyle(color: Colors.white),
                                  controller: currentDate,
                                  onTap: () {
                                    setState(() {
                                      _presentDatePicker(context);
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white24, width: 2.0),
                                    ),
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.white70),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 2.0),
                                    ),
                                    labelText: "Date of birth",
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                  ),
                                  validator: dateValidate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 48,
                  child: ElevatedButton(
                      style: !buttonEnabled
                          ? AppTheme.mainButtonDisabled
                          : AppTheme.mainButton,
                      onPressed: buttonEnabled ? addChild : null,
                      child: SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Add Child',
                            style: TextStyle(
                                color: !buttonEnabled
                                    ? const Color(0xFF8B7EDF)
                                    : AppTheme.darkPurple),
                          )),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? nameValidate(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter your kid name';
    }

    if (name.length < 5 || name.length > 50) {
      return 'Name must be between 2 and 50 characters';
    }

    return null;
  }

  void selectAvatar(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Wrap(
          children: [
            ListTile(
              title: Text(
                'Upload your avatar',
                style: theme.textTheme.subtitle1
                    ?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              tileColor: AppTheme.primary,
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              minLeadingWidth: 0,
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              minLeadingWidth: 0,
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  Future addChild() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('children');

    final json = {
      'uid': currentUser!.uid,
      'name': name.text,
      'birthday': pickDate,
      'create_date': DateTime.now(),
      'points': 0
    };

    changeHasKids(true);

    return users.add(json).then((value) {
      changeHasKids(true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((error) {});
  }

  Future changeHasKids(bool hasKids) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final user =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);

    Map<String, dynamic> data = <String, dynamic>{
      'hasKids': hasKids,
    };

    await user.update(data).whenComplete(() {});
  }

  String? dateValidate(String? currentDate) {
    if (currentDate == null || currentDate.isEmpty) {
      return r"Please enter your kid's birthday";
    }

    if (currentDate.length > 10) {
      return 'Invalid date.';
    }

    String pattern = r"\d{1,2}/\d{1,2}/\d{4}";
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(currentDate) ? null : 'Invalid date.';
  }

  _presentDatePicker(BuildContext context) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppTheme.primary,
                    onPrimary: Colors.white,
                    onSurface: AppTheme.darkPurple,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: AppTheme.primary, // button text color
                    ),
                  )),
              child: child!);
        }).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      currentDate.text =
          "${pickedDate.toLocal().day}/${pickedDate.toLocal().month}/${pickedDate.toLocal().year}";
      pickedDate = selectedDate = pickedDate;
      pickDate = pickedDate;
      setState(() {});
    });
    if (_formKey.currentState!.validate()) {
      buttonEnabled = true;
      setState(() {});
    } else {
      buttonEnabled = false;
      setState(() {});
    }
  }
}
