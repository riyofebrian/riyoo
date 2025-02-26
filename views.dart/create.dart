import 'dart.convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/widget/form.dart';
import 'package:biodata/widget/from.dart';
import 'dart:async';

class Create extends StatefulWidget {

    @override
    CreateState createState() => CreateState();
}

class CreateState extends State<Create> {
    final formkey = GlobalKey<FormState>();

    TextEditingController nisController = new  TextEditingController();
     TextEditingController namaController = new  TextEditingController();
      TextEditingController tpController = new  TextEditingController();
       TextEditingController tgController = new  TextEditingController();
        TextEditingController kelaminController = new  TextEditingController();
         TextEditingController agamaController = new  TextEditingController();
          TextEditingController alamatController = new  TextEditingController();

          Future createSw() async {
            return await http.post(
                Uri.parse(Baseurl.tambah),
                body: {
                    "nis": nisController.text,
                    "nama": namaController.text,
                    "tplahir": tpController.text,
                    "tglahir": tgController.text,
                    "kelamin": kelaminController,
                    "agama": agamaController.text,
                    "alamat": alamatController.text,
                },
            );
          }

          void _onConfirm(context) async {
            http.Response response = await createSw();
            final data = json.decode(response.body);
            if (data['succes']) {
                Navigator.of(conext)
                    .pushNameAndRemoveUntil('/', (Route<dynamic> route) =>false);
            }
          }

          @override
          Widget build(BuildContext contex) {
            return Scaffold(
                appBar: AppBar(
                    title: Text("Tambah Siswa"),
                    centerTitle: true,
                    backgroundColor: colors.blue,
                ),    // AppBar
                bottomNavigationBar: BottomAppBar(
                    child: ElevatedButton(
                        child: Text("Simpan"),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.green,
                            textStyle: TextStyle(fontWidget: FontWeight.bold, fontSize: 24)
                        ),
                        onPresseed: () {
                            if(formkey.currentState!.validate()) {
                                // print(context);
                                print("OK SUKSES");
                                _onConfirm(context);
                            }
                        },
                    ),    // ElevatedButton
                ),      // BottomAppBar
                body: Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: AppForm(
                                formkey: formkey,
                                nisController: nisController,
                                namaController: namaController,
                                tpController: tpController,
                                tgController: tgController,
                                kelaminController: kelaminController,
                                agamaController: agamaController,
                                alamatController: alamatController,
                            ),    //AppForm
                        ),      //Padding
                    ),        //Center
                ) ,          // Container
            );            // Scaffold
          }
}