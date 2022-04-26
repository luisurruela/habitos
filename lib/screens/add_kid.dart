import 'package:flutter/material.dart';

class AddKidScreen extends StatelessWidget {
  const AddKidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your kid')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text('Create your son profile'),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Name', icon: Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Birthday  ',
                        icon: Icon(Icons.calendar_month))),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                  labelText: 'Avatar  ',
                  icon: Icon(Icons.upload),
                )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Create')),
                      ),
                    ))
              ],
            )),
          )
        ],
      )),
    );
  }
}
