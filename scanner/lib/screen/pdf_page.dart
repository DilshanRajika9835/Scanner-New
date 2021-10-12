import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanner/screen/pdf_screen.dart';

class PDFPage extends StatefulWidget {
  const PDFPage({Key? key}) : super(key: key);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  final Directory _photoDir = Directory('/storage/emulated/0/Scanner');
  String pathPDF = "";
  final List<File> imageFiles = [];
  var files = "Hello";
  @override
  void initState() {
    print(_photoDir.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_photoDir.path).existsSync()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("TapScanner PDF"),
        ),
        body: const Center(
          child: Text(
            "All TapScanner PDF should appear here",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".pdf"))
          .toList(growable: false);

      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tpScanner.png'),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(0.4), BlendMode.darken)
            ),
          ),
          child: ListView.builder(
            //if file/folder list is grabbed, then show here
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];

              return Card(
                  child: ListTile(
                title: Text(imgPath),
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PDFScreen(path: imgPath);
                  }));
                },
              ));
            },
          ),
        ),
      );
    }
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      //  File file = File("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
