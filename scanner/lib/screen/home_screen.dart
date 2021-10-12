import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final images = ImagePicker();
  File? image;
  bool isloading = true;
  String filepath = "";
  @override
  void initState() {
    super.initState();
    createFolder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tpScanner.png'),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(0.4), BlendMode.darken)
            ),
          ),
          // child: _widgetOptions.elementAt(_selectedIndex),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: IconButton(
                icon: Image.asset("assets/img4.png"),
                iconSize: 60.0,
                onPressed: () => Scaffold.of(context).openDrawer())),
        Positioned(
            bottom: 0,
            left: 210,
            child: IconButton(
                icon: Image.asset("assets/gallery4.png"),
                iconSize: 60.0,
                onPressed: () => {pickGalleryImage(), showModal()})),
        Center(
          child: Container(
            width: 300,
            height: 360,
            decoration: BoxDecoration(
              border: Border.all(
                  // color: Colors.blue,
                  color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Expanded(
                child: isloading
                    ? Center(
                        child: Center(
                        child: Container(
                          width: 300,
                          height: 330,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/scanning.gif'),
                              fit: BoxFit.fill,
                              // colorFilter: ColorFilter.mode(
                              //     Colors.black.withOpacity(0.4),
                              //     BlendMode.darken)
                            ),
                          ),
                        ),
                      ))
                    : image != null
                        ? Center(
                            child: Image.file(
                              image!,
                              width: 300,
                              fit: BoxFit.contain,
                            ),
                          )
                        // : CircularProgressIndicator()

                        : Center(
                            child: Center(
                            child: Container(
                              width: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/scanning.gif'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
              )
            ]),
          ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              camerpickImage();
              showModal();
            },
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  shape: BoxShape.circle,
                  color: Colors.red),
              child: const Icon(Icons.camera_alt, size: 40),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future camerpickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      cropSquareImage(File(image.path));
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Fail to pick Image :$e");
    }
  }

  cropSquareImage(File imageTempory) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageTempory.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLocked(),
    );
    if (croppedFile != null) {
      setState(() {
        image = croppedFile;
        isloading = false;
      });
    }
  }

  // ignore: prefer_const_constructors
  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
      toolbarTitle: 'Tap Scanner',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
      hideBottomControls: false,
      lockAspectRatio: false);
  Future pickGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      cropSquareImage(File(image.path));

      //  saveimgDir(File(image.path));
    } on PlatformException catch (e) {
      print("Fail to pick Image :$e");
    }
  }

  //===========================================================
  Widget buildSheeet() => Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        // image: DecorationImage(
        //     image: AssetImage("assets/cancel.png"),
        //     fit: BoxFit.fill,
        //     colorFilter: ColorFilter.mode(
        //         Colors.black.withOpacity(0.1), BlendMode.darken))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 50,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.save),
            title: const Text('Save Photo'),
            onTap: () {
              saveimgDir(File(image!.path));
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('Convert PDF'),
            onTap: () {
              convertPDF(File(image!.path));
            },
          ),
          ListTile(
            leading: const Icon(Icons.change_circle),
            title: const Text('Change Image'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ));
  showModal() {
    showModalBottomSheet(
        context: context,
        enableDrag: true, //drag option
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => buildSheeet());
  }

  //------------------Create Folder ------------------------------------
  Future<bool> createFolder() async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;

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

          directory = Directory(newPath);
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          setState(() {
            filepath = directory.path;
          });

          return true;
        } else {
          //return (await getExternalStorageDirectory())!;
        }
      }
      // ignore: empty_catches
    } catch (e) {}
    directory = (await getExternalStorageDirectory())!;
    setState(() {
      filepath = directory.path;
    });
    return false;
  }

  //get User Permission
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

  //-----------------Save Image To Gallery------------------------
  Future saveimgDir(File file) async {
    File tmpFile = File(file.path);
    String date = getData();
    String newname = date + "img.png";

    tmpFile = await tmpFile.copy('$filepath/$newname');
    if (tmpFile.isAbsolute) {
      successTost("Image Save Successfully!", 1);
    } else {
      successTost("Image Save Fail!", 0);
    }
  }

  //---------------toast ----------------------
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

  //-------Convart PDF----------------------------------------
  Future<void> convertPDF(File location) async {
    final image = pw.MemoryImage(location.readAsBytesSync());
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Center(
          child: pw.Image(image),
        ),
      ),
    );
    // Directory directory = (await getExternalStorageDirectory())!;

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
}
