import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

final Directory _photoDir = Directory('/storage/emulated/0/Scanner');

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  GalleryScreenState createState() {
    return GalleryScreenState();
  }
}

class GalleryScreenState extends State {
  String pathPDF = "";
  final List<File> imageFiles = [];
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    // fromAsset('assets/demo.pdf', 'demo.pdf').then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_photoDir.path).existsSync()) {
      return const Scaffold(
        body: Center(
          child: Text(
            "All TapScanner images should appear here",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".png"))
          .toList(growable: false);

      if (imageList.isNotEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("TapScanner Images"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/tpScanner.png'),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //     Colors.black.withOpacity(0.4), BlendMode.darken)
              ),
            ),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  String path = imageList[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(path),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                deleteImage(imageList[index]);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: const Text(
                "Sorry, No Images Where Found.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      }
    }
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      //  File file = File("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      print(file.path);
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  deleteImage(String path) async {
    bool isExist = await File(path).exists();
    if (isExist) {
      var deleted = await File(path).delete();
      if (deleted.isAbsolute) {
        successTost("Image Delete Successfully", 1);
      } else {
        successTost("Image Delete Fail try again", 0);
      }
    }
  }

  void successTost(String text, int color) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color != 0 ? Colors.green[800] : Colors.red[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
