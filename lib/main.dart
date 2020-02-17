import 'package:flutter/material.dart';
import 'package:myappp/add.dart';
import 'package:myappp/detail.dart';
import 'package:myappp/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> items = [];
  @override
  void initState() {
    items = List.generate(10, (i) {
      return Todo("Item $i", "Description $i", "22/2/2222");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: _generateListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo result = await Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddPage()));
          setState(() {
            items.add(result);
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  _generateListView() {
    return ListView.builder(
      itemBuilder: (BuildContext contex, int index) {
        return Card(
            child: ListTile(
                title: Text(items[index].itemName),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text("Due at: ${items[index].itemDate}"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => DetailPage(
                              items[index].itemName,
                              items[index].itemDesc,
                              items[index].itemDate)));
                },
                onLongPress: () {
                  _showAlertToDelete(index);
                }));
      },
      itemCount: items.length,
      padding: EdgeInsets.all(8.0),
    );
  }

  _showAlertToDelete(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("OK!"),
                onPressed: () {
                  //delete
                  setState(() {
                    items.removeAt(index);
                  });

                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}