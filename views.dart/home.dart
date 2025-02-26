import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
// import 'package:biodata/views/details.dart';
// import 'package:biodata/views/create.dart';

import 'package:http/http.dart' as http;

class home extends StatefulWidget {
    home({Key? key}) : super(key: key);
    @override
    HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
    late Future<List<SiswaModel>();
    final swListkey = GlobalKey<HomeState>();

    @override
    void initState() {
        super.initState();
        sw = getSwList();
    }

    Future<List<SiswaModel>> getSwList() async {
        final response = await http.get(Uri.parse(BaseUrl.data));
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<SiswaModel> sw = items.map<SiswaModel>((json) {
            return SiswaModel.fromjson(Json);
        }).toList();
        return sw;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("List Data Siswa"),
                centerTitle: true,
                backgroundColor: Colors.blue,
            ), //AppBar
            body: Center(
                child: FutureBuilder<List<SiswaModel>>(
                    future: sw,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!sanpshot.hasData) return CircularProgessIndicator();
                        return ListView.builder(
                            itemCount: sanpshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data[index];
                                return Card(
                                    child: ListTitle(
                                        leading: Icon(Icons.person),
                                        trailing: Icon(Icons.view_list),
                                        title: Text(
                                            data.nis + " " + data.nama,
                                            style: TextStyle(fontSize: 20),
                                        ), // Text
                                        subtitle: Text(data.tplahir + "," + data.tglahir),
                                        onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(
                                            //       builder:(context) => Details(sw: data)),
                                            // );
                                        },
                                    ),   // ListTile
                                );   // Card
                            });
                    },
                ),  // FutureBuilder
            ),   // Center
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                hoverColor: Color.green,
                backgroundColor: colors.deepOrange,
                onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //    return Create();
                    // }));
                },
            ),   // FloatingActionBitton
        );   // Scaffold
    }
}