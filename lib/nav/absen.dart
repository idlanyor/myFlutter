// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dialogs/flutter_dialogs.dart';

class Absen extends StatefulWidget {
  const Absen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AbsenState createState() => _AbsenState();
  
}

class _AbsenState extends State<Absen> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String apiUrl =
      "https://script.google.com/macros/s/AKfycbwrOkmErNhdEhtOrC3ENMO4qM-VAOES2AMxmcod8dI6U14tbBf_gvEslNbG2qJOeW-MFw/exec";

  final TextEditingController _nimController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    super.dispose();
  }

  Future<void> fetchData(String nim) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse("$apiUrl?nim=$nim"));
    final jsonData = jsonDecode(response.body);

    setState(() {
      isLoading = false;
    });

    if (jsonData['status'] == 'success') {
      final message = jsonData['message'];
      // ignore: use_build_context_synchronously
      await showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
          title: const Text("Presensi Mahasiswa"),
          content: Text(message),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      String errorMessage = jsonData['message'];
      // ignore: use_build_context_synchronously
      await showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
          title: Text("Presensi Gagal"),
          content: Text(errorMessage),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Absen',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          final nim = _nimController.text;
          fetchData(nim);
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Absensi Mata Kuliah English #95"),
    //   ),
    //   body: Center(
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           TextFormField(
    //             controller: _nimController,
    //             validator: (value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Kolom nim tidak boleh kosong';
    //               }
    //               return null;
    //             },
    //             decoration: const InputDecoration(
    //               labelText: 'NIM',
    //               hintText: 'Masukkan NIM',
    //               prefixIcon: Icon(Icons.assignment_ind_outlined),
    //               border: OutlineInputBorder(),
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           SizedBox(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4)),
    //               ),
    //               child: const Padding(
    //                 padding: EdgeInsets.all(10.0),
    //                 child: Text(
    //                   'Absen',
    //                   style:
    //                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               onPressed: () {
    //                 if (_formKey.currentState?.validate() ?? false) {
    //                   fetchData(_nimController.text);
    //                 }
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child:
       Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Kolom nim tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'NIM',
                hintText: 'Masukkan NIM',
                prefixIcon: Icon(Icons.assignment_ind_outlined),
                border: OutlineInputBorder(),
              ),
              controller: _nimController,
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: isLoading ? _buildLoadingIndicator() : _buildButton(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _gap() => const SizedBox(height: 16);
}
