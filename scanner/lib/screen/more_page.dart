import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/screen/create_pdfpage.dart';
import 'package:scanner/screen/img_page.dart';
import 'package:scanner/screen/pdf_page.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // final ScrollController _scrollController = ScrollController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tap Scanner",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(text: "Images"),
              Tab(text: "Create PDF"),
              Tab(text: "View PDF"),
            ],
          ),
        ),
        // body: ListView.builder(
        //   itemCount: 5,
        //   // itemCount: _listViewData.length,
        //   controller: _scrollController,
        //   reverse: true,
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     return const ListTile(
        //         title: Text("Folder"),
        //         subtitle: Text("Cast your vote."),
        //         leading: CircleAvatar(
        //             backgroundColor: Colors.white,
        //             backgroundImage: AssetImage("assets/folder.png")),
        //         trailing: Icon(Icons.star));
        //   },
        // ),
        body: const TabBarView(
          children: <Widget>[
            ImgPage(),
            CreatePDFPage(),
            PDFPage(),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        // saveFile();
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Create New Folder"),
      content: SizedBox(
          height: 60,
          child: TextFormField(
            maxLines: 1,
            maxLength: 10,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: const InputDecoration(
                // counterText: '',
                border: InputBorder.none,
                hintText: "Enter your FolderName",
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> saveFile(String url, String filename) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);

          ///storage/emulated/0/Android/data/com.example.tapscanner/files
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Scanner";
          print(newPath);
          directory = Directory(newPath);
          print(directory.path);
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var request = permission.request();
      // ignore: unrelated_type_equality_checks
      if (request == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });
    bool download = await saveFile("", "");
    if (download) {
      print("Download Successfully");
    } else {
      print("Save Fail");
    }
    setState(() {
      loading = false;
    });
  }
}
