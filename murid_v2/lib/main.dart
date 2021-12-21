import 'dart:async';
import 'package:flutter/material.dart';
import 'package:murid_v2/service/muridService.dart';
import 'package:murid_v2/view/addMurid.dart';
import 'package:murid_v2/view/search.dart';
import 'model/murid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future data;
  List<Murid> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void ambilData() {
    data = MuridService().getMurid();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    ambilData();
  }

  void navigateAddMurid() {
    Route route = MaterialPageRoute(builder: (context) => AddMurid());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  void initState() {
    ambilData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !isSearching
              ? Text("List Murid",
                  style: TextStyle(color: Colors.black, fontSize: 26))
              : TextField(
                  controller: searchText,
                  style: TextStyle(color: Colors.black, fontSize: 26),
                  decoration: InputDecoration(
                      hintText: "Pencarian",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SearchMurid(keyword: searchText.text)));
                  },
                ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    this.isSearching = !this.isSearching;
                  });
                },
                icon: !isSearching
                    ? Icon(Icons.search, color: Colors.black)
                    : Icon(Icons.cancel, color: Colors.black))
          ]),
      body: data2.length == 0
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: data2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data2[index].nameMurid),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAddMurid();
        },
        tooltip: 'Tambah Data',
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
