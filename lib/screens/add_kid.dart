import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AddKidScreen extends StatelessWidget {
  const AddKidScreen({Key? key}) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                  child: Row(
                children: [
                  SizedBox(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  )
                ],
              )),
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
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF3220A1),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: AppTheme.tertiary,
                              radius: 18.0,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 20.0,
                                color: AppTheme.darkPurple,
                              ),
                            ),
                          ),
                          radius: 60.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: width,
                      child: Form(
                          child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white38, width: 2.0),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.white70),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white70, width: 2.0),
                              ),
                              labelText: "Child's Name",
                              labelStyle: TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            validator: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white38, width: 2.0),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.white70),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white70, width: 2.0),
                              ),
                              labelText: "Date of birth",
                              labelStyle: TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            validator: null,
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
                height: 60,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 48,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(218, 240, 75, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))))),
                    onPressed: () {},
                    child: const SizedBox(
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Add Child',
                          style: TextStyle(color: AppTheme.darkPurple),
                        )),
                      ),
                    )),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
