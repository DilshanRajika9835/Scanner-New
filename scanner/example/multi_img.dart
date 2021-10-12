// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:multi_image_picker/multi_image_picker.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Asset> images = <Asset>[];
//   String _error = "error";

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget buildGridView() {
//     // ignore: unnecessary_null_comparison
//     if (images != null) {
//       return GridView.count(
//         crossAxisCount: 3,
//         children: List.generate(images.length, (index) {
//           Asset asset = images[index];
//           return AssetThumb(
//             asset: asset,
//             width: 300,
//             height: 300,
//           );
//         }),
//       );
//     } else {
//       return Container(color: Colors.white);
//     }
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Center(child: Text('Error: $_error')),
//             // ignore: deprecated_member_use
//             RaisedButton(
//               child: const Text("Pick images"),
//               onPressed: loadAssets,
//             ),
//             Expanded(
//               child: buildGridView(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> loadAssets() async {
//     setState(() {
//       images = <Asset>[];
//     });

//     List<Asset> resultList = <Asset>[];

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//       );
//     } on Exception catch (e) {
//       _error = e.toString();
//     }
//     if (!mounted) return;

//     setState(() {
//       images = resultList;
//       _error;
//     });
//   }
// }
