import 'package:dev_connect/Screens/TabScreens/ExploreTabContent/ExploreTab.dart';
import 'package:dev_connect/Screens/TabScreens/FavouriteTabContent/FavouriteTab.dart';
import 'package:dev_connect/Screens/TabScreens/HomeTabContent/HomeTab.dart';
import 'package:dev_connect/Screens/TabScreens/ProjectsTabContent/ProjectTab.dart';
import 'package:dev_connect/Screens/UserAccountScreens/AccountDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    FavouriteTab(),
    ExploreTab(),
    ProjectTab()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: Column(
            children: [
              Padding(
                //Custom Top Bar
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Hero(
                      tag: "logo",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Row(
                          children: const [
                            Image(
                              image: AssetImage(
                                  "assets/images/devconnect-logo.png"),
                              height: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Dev Connect",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountDetailsScreen()));
                      },
                      icon: const Icon(
                        Icons.person,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_widgetOptions.elementAt(_selectedIndex)],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.yellowAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              label: 'Projects',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.teal,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
