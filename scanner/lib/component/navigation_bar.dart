import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner/screen/more_page.dart';
import 'package:scanner/screen/home_screen.dart';
import 'package:scanner/screen/gallery_screen.dart';
import 'package:scanner/screen/qr_scanner.dart';

class BottomNavigationContainor extends StatefulWidget {
  const BottomNavigationContainor({Key? key}) : super(key: key);

  @override
  _BottomNavigationContainorState createState() =>
      _BottomNavigationContainorState();
}

class _BottomNavigationContainorState extends State<BottomNavigationContainor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  List<File> imageFiles = [];
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const GalleryScreen(),
    const MorePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: SizedBox(
          //padding: EdgeInsets.only(top: 24),
          width: 250,
          child: Drawer(
            elevation: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 190,
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0062ac),
                    ),
                    accountName: const Text("Marcelo Augusto Elias"),
                    accountEmail: const Text("Matrícula: 5046850"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? const Color(0xFF0062ac)
                              : Colors.white,
                      backgroundImage: const AssetImage('assets/user.gif'),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        dense: true,
                        title: const Text("Upgrade to Primium"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img5.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Remove ads"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img8.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Signature"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img7.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Backup to cloud"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img11.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("HD quality"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img13.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Rate Us"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img9.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Setting"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img12.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("Contact Us"),
                        onTap: () {},
                        leading: Image.asset(
                          "assets/img6.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: const Text("QR Scanner"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QRScanner()));
                        },
                        leading: Image.asset(
                          "assets/img10.png",
                          width: 30.0,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage('assets/img3.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken)),
            ),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),

      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(top: 20),
      //   child: SizedBox(
      //     height: 70,
      //     width: 70,
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.transparent,
      //       elevation: 0,
      //       onPressed: () {
      //         _onItemTap(2);
      //       },
      //       child: Container(
      //         height: 75,
      //         width: 75,
      //         decoration: BoxDecoration(
      //             border: Border.all(color: Colors.white, width: 4),
      //             shape: BoxShape.circle,
      //             color: Colors.red),
      //         child: Icon(Icons.camera_alt, size: 40),
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image_rounded),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        onTap: _onItemTap,
        selectedFontSize: 15.0,
        unselectedFontSize: 13.0,
        // backgroundColor: Colors.white, //here set your transparent level
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
