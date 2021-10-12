import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CreatePDFPage extends StatefulWidget {
  const CreatePDFPage({Key? key}) : super(key: key);

  @override
  _CreatePDFPageState createState() => _CreatePDFPageState();
}

class _CreatePDFPageState extends State<CreatePDFPage> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  String filepath = "";
  final List<File> _image = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Build PDF File"),
        actions: [
          IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () {
                convertPDF();
              })
        ],
      ),
      body: _image != null
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/tpScanner.png'),
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.4), BlendMode.darken)
                ),
              ),
              child: ListView.builder(
                itemCount: _image.length,
                itemBuilder: (context, index) => Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    child: Image.file(
                      _image[index],
                      fit: BoxFit.cover,
                    )),
              ),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: getImageFromGallery,
      ),
    );
  }

  getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> convertPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
    var bool = await createFolder();
    if (bool) {
      String date = getData();
      String newname = date.toString() + "img.pdf";
      final file = File("$filepath/$newname");
      await file.writeAsBytes(await pdf.save());
    }
  }

  String getData() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hhmmssaaa').format(now);
    return formattedDate;
  }

  Future<bool> createFolder() async {
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
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          setState(() {
            filepath = directory.path;
          });
          print(directory.path);
          return true;
        } else {
          //return (await getExternalStorageDirectory())!;
        }
      }
    } catch (e) {
      print(e);
    }
    directory = (await getExternalStorageDirectory())!;
    setState(() {
      filepath = directory.path;
    });
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
}
