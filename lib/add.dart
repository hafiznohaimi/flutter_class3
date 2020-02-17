import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:myappp/todo.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final namecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  // final datecontroller = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  String dateSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Item")),
      body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: " Enter item name"),
                controller: namecontroller,
              ),
              TextField(
                decoration: InputDecoration(hintText: " Enter item description"),
                controller: descriptioncontroller,
              ),
              // TextField(
              //   keyboardType: TextInputType.datetime,
              //   decoration: InputDecoration(
              //     hintText: "Enter item date"
              //   ),
              //   controller: datecontroller,
              // ),
              DateTimeField(
                decoration: InputDecoration(hintText: " Please choose a date"),
                format: format,
                onChanged: (dt) {
                  setState(() {
                    dateSelected = "${dt.day}/${dt.month}/${dt.year}";
                  });
                },
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              FlatButton(
                  onPressed: () {

                    print(
                        " Name ${namecontroller.text} Description ${descriptioncontroller.text} Date $dateSelected");
                    Todo newTodo = Todo(namecontroller.text, descriptioncontroller.text, dateSelected);
                    Navigator.pop(context, newTodo);
                  },
                  child: Text("Save"))
            ],
          )),
    );
  }
}