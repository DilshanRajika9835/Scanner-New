import 'package:flutter/material.dart';

class ShareFile extends StatefulWidget {
  const ShareFile({Key? key}) : super(key: key);

  @override
  _ShareFileState createState() => _ShareFileState();
}

class _ShareFileState extends State<ShareFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap Scanner"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage('assets/img3.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken)),
            ),
            // child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget buildSheeet() => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
            image: DecorationImage(
                image: const AssetImage("assets/cancel.png"),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.darken))),
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: GridView.count(
              // mainAxisSize: MainAxisSize.min,

              crossAxisCount: 3,
              // crossAxisSpacing: 2,
              childAspectRatio: 1,
              children: [
                ListTile(
                  dense: true,
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  onTap: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  dense: true,
                  onTap: () {
                    setState(() {});

                    Navigator.pop(context);
                  },

                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  dense: true,

                  onTap: () {
                    setState(() {});

                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  dense: true,
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  onTap: () {
                    setState(() {});

                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  dense: true,
                  //  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  onTap: () {
                    setState(() {});
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  dense: true,
                  onTap: () {
                    setState(() {});
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    setState(() {});
                  },
                  //  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
                ListTile(
                  dense: true,
                  //  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  onTap: () {
                    setState(() {});
                  },
                  leading: Image.asset(
                    "assets/cancel.png",
                    width: 50.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  showModal() {
    showModalBottomSheet(
        context: context,
        enableDrag: true, //drag option
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => buildSheeet());
  }
}
