// // ignore_for_file: import_of_legacy_library_into_null_safe

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';

// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({Key? key}) : super(key: key);

//   @override
//   _GalleryScreenState createState() => _GalleryScreenState();
// }

// class _GalleryScreenState extends State<GalleryScreen> {
//   final images = ImagePicker();
//   File? image;
//   bool isloading = true;
//   String filepath = "";
//   bool initialized = false;

//   String word = "TEXT";

//   @override
//   void initState() {
//     super.initState();
//     createFolder();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: const AssetImage('assets/img3.jpg'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                     Colors.black.withOpacity(0.4), BlendMode.darken)),
//           ),
//         ),
//         Positioned(
//             top: 10,
//             left: 10,
//             child: IconButton(
//                 icon: Image.asset("assets/img4.png"),
//                 iconSize: 60.0,
//                 onPressed: () => Scaffold.of(context).openDrawer())),
//         Center(
//           child: Container(
//             width: 300,
//             height: 360,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   // color: Colors.blue,
//                   color: Colors.white),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             padding: const EdgeInsets.all(5),
//             child: Column(children: [
//               Expanded(
//                 child: isloading
//                     ? Center(
//                         child: Center(
//                         child: Container(
//                           width: 300,
//                           height: 330,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: const AssetImage('assets/scanning.gif'),
//                                 fit: BoxFit.fill,
//                                 colorFilter: ColorFilter.mode(
//                                     Colors.black.withOpacity(0.4),
//                                     BlendMode.darken)),
//                           ),
//                         ),
//                       ))
//                     : image != null
//                         ? Image.file(
//                             image!,
//                             width: 300,
//                             height: 330,
//                             fit: BoxFit.fill,
//                           )
//                         // : CircularProgressIndicator()
//                         : Center(
//                             child: Center(
//                             child: Container(
//                               width: 300,
//                               height: 330,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image:
//                                         const AssetImage('assets/scanning.gif'),
//                                     fit: BoxFit.cover,
//                                     colorFilter: ColorFilter.mode(
//                                         Colors.black.withOpacity(0.4),
//                                         BlendMode.darken)),
//                               ),
//                             ),
//                           )),
//               )
//             ]),
//           ),
//         ),
//         Container(
//             child: MediaQuery.of(context).orientation == Orientation.landscape
//                 ? Positioned(
//                     top: 210,
//                     left: 440,
//                     child: IconButton(
//                       icon: Image.asset("assets/cancel.png"),
//                       iconSize: 40.0,
//                       onPressed: () {},
//                     ))
//                 : Positioned(
//                     top: 60,
//                     left: 300,
//                     child: IconButton(
//                       icon: Image.asset("assets/cancel.png"),
//                       iconSize: 40.0,
//                       onPressed: () {},
//                     )))
//       ]),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(3),
//         child: SizedBox(
//           height: 70,
//           width: 70,
//           child: FloatingActionButton(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             onPressed: () {
//               pickGalleryImage();
//               // showModal();
//               // camerpickImage();
//             },
//             child: Container(
//               height: 75,
//               width: 75,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 4),
//                   shape: BoxShape.circle,
//                   color: Colors.blue),
//               child: const Icon(Icons.image, size: 40),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   cropSquareImage(File imageTempory) async {
//     File? croppedFile = await ImageCropper.cropImage(
//       sourcePath: imageTempory.path,
//       aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       compressQuality: 70,
//       compressFormat: ImageCompressFormat.jpg,
//       androidUiSettings: androidUiSettingsLocked(),
//     );
//     if (croppedFile != null) {
//       setState(() {
//         image = croppedFile;
//         isloading = false;
//       });
//     }
//     await convertPDF(croppedFile!);
//   }

//   AndroidUiSettings androidUiSettingsLocked() => const AndroidUiSettings(
//       toolbarTitle: 'Tap Scanner',
//       toolbarColor: Colors.blue,
//       toolbarWidgetColor: Colors.white,
//       hideBottomControls: false,
//       lockAspectRatio: false);

//   Future pickGalleryImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       cropSquareImage(File(image.path));

//       saveimgDir(File(image.path));
//     } on PlatformException catch (e) {
//       print("Fail to pick Image :$e");
//     }
//   }

//   //============Show Modal Section==========================

//   Widget buildSheeet() => Container(
//         padding: const EdgeInsets.all(5),
//         decoration: const BoxDecoration(
//           //borderRadius: BorderRadius.circular(10),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//             bottomLeft: Radius.zero,
//             bottomRight: Radius.zero,
//           ),
//           // image: DecorationImage(
//           //     image: AssetImage("assets/cancel.png"),
//           //     fit: BoxFit.fill,
//           //     colorFilter: ColorFilter.mode(
//           //         Colors.black.withOpacity(0.1), BlendMode.darken))
//         ),
//         height: 200,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: GridView.count(
//               // mainAxisSize: MainAxisSize.min,

//               crossAxisCount: 3,
//               // crossAxisSpacing: 2,
//               childAspectRatio: 1,
//               children: [
//                 ListTile(
//                   dense: true,
//                   // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
//                   onTap: () {
//                     setState(() {});
//                     Navigator.pop(context);
//                   },
//                   leading: Image.asset(
//                     "assets/pdf.png",
//                     width: 50.0,
//                   ),
//                 ),
//                 ListTile(
//                   dense: true,
//                   //contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
//                   onTap: () {
//                     setState(() {});
//                   },
//                   leading: Image.asset(
//                     "assets/pdf.png",
//                     width: 50.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   showModal() {
//     showModalBottomSheet(
//         context: context,
//         enableDrag: true, //drag option
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//         builder: (context) => buildSheeet());
//   }

//   Future<void> convertPDF(File location) async {
//     final image = pw.MemoryImage(location.readAsBytesSync());
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) => pw.Center(
//           child: pw.Image(image),
//         ),
//       ),
//     );
//     // Directory directory = (await getExternalStorageDirectory())!;
//     // print(directory);
//     var bool = await createFolder();
//     if (bool) {
//       final file = File("$filepath/example3.pdf");
//       await file.writeAsBytes(await pdf.save());
//     }
//   }

//   Future<bool> createFolder() async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = (await getExternalStorageDirectory())!;
//           print(directory.path);

//           ///storage/emulated/0/Android/data/com.example.tapscanner/files
//           String newPath = "";
//           List<String> folders = directory.path.split("/");
//           for (int x = 1; x < folders.length; x++) {
//             String folder = folders[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/Scanner";
//           print(newPath);
//           directory = Directory(newPath);
//           if (!await directory.exists()) {
//             await directory.create(recursive: true);
//           }
//           setState(() {
//             filepath = directory.path;
//           });
//           print(directory.path);
//           return true;
//         } else {
//           //return (await getExternalStorageDirectory())!;
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//     directory = (await getExternalStorageDirectory())!;
//     setState(() {
//       filepath = directory.path;
//     });
//     return false;
//   }

// //get User Permission
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var request = permission.request();
//       // ignore: unrelated_type_equality_checks
//       if (request == PermissionStatus.granted) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }

//   Future saveimgDir(File file) async {
//     // final pickedImage =
//     //     await ImagePicker().pickImage(source: ImageSource.gallery);

//     // if (pickedImage == null) return;

//     File tmpFile = File(file.path);
//     tmpFile = await tmpFile.copy('$filepath/image1.png');
//   }

 
// }
