import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murid_v2/view/search.dart';
import 'package:murid_v2/service/muridService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddMurid extends StatefulWidget {
  const AddMurid({Key? key}) : super(key: key);

  @override
  _AddMuridState createState() => _AddMuridState();
}

class _AddMuridState extends State<AddMurid> {
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  TextEditingController nisnController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  String? jenisKelamin;
  int count = 0;

  void createData() {
    MuridService()
        .saveMurid(
            nisnController.text,
            nameController.text,
            emailController.text,
            phoneController.text,
            addressController.text,
            jenisKelamin!,
            kelasController.text)
        .then((value) {
      setState(() {
        if (value) {
          Alert(
              context: context,
              title: "Berhasil",
              desc: "Data telah berhasil disimpan",
              type: AlertType.success,
              buttons: [
                DialogButton(
                    child: Text("OK",
                        style: TextStyle(color: Colors.white, fontSize: 26)),
                    onPressed: () {
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    })
              ]).show();
        } else {
          Alert(
              context: context,
              title: "GAGAL!!!!!",
              desc: "Alhamdulillah Gagal YA ALLAH",
              type: AlertType.error,
              buttons: [
                DialogButton(
                    child: Text("OK",
                        style: TextStyle(color: Colors.white, fontSize: 26)),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !isSearching
              ? Text("Tambah Data Murid",
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
          iconTheme: IconThemeData(color: Colors.black),
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          TextField(
            controller: nisnController,
            decoration: InputDecoration(
                hintText: "Masukkan NISN",
                labelText: "NISN Murid",
                icon: Icon(Icons.assignment_outlined)),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: "Masukkan Nama",
                labelText: "Nama Murid",
                icon: Icon(Icons.people)),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "Masukkan Email",
                labelText: "Email Murid",
                icon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
                hintText: "Masukkan Nomor Telpon",
                labelText: "Telpon Murid",
                icon: Icon(Icons.phone)),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
                hintText: "Masukkan Alamat",
                labelText: "Alamat Murid",
                icon: Icon(Icons.place)),
          ),
          Row(
            children: [
              Radio(
                  value: 'pria',
                  groupValue: jenisKelamin,
                  onChanged: (String? value) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  }),
              Text("Pria", style: TextStyle(fontSize: 26)),
              Radio(
                  value: 'perempuan',
                  groupValue: jenisKelamin,
                  onChanged: (String? value) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  }),
              Text("Perempuan", style: TextStyle(fontSize: 24)),
            ],
          ),
          TextField(
            controller: kelasController,
            decoration: InputDecoration(
                hintText: "Masukkan Kelas",
                labelText: "Kelas Murid",
                icon: Icon(Icons.house)),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                createData();
              },
              child: Text("Simpan Data", style: TextStyle(fontSize: 24)))
        ],
      )),
    );
  }
}
