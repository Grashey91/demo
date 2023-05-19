import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/rahul/photo.dart';
import 'package:flutter_application_1/rahul/settings.dart';

import 'notes.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPage = 0;

  List<Widget> screens = [Home(), Photo(), Notes(), Settings()];
  void _onItemTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: myBottomNavBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 63, 231, 69),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              builder: (context) {
                return Wrap(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.camera_alt_outlined),
                      title: Text('Take Photo'),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Upload Photo'),
                    ),
                    ListTile(
                      leading: Icon(Icons.note_add),
                      title: Text('Add Notes'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  myBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
          label: 'Photo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentPage,
      selectedItemColor: Colors.blue,
      iconSize: 30,
      onTap: (value) {
        setState(() {
          currentPage = value;
        });
      },
    );
  }
}
