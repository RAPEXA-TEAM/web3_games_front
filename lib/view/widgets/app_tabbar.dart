import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatefulWidget {
  final List<AppTab> tabs;
  final TabController? tabController;
  final List<Widget> pages;

  const AppTabBar(
      {Key? key, required this.tabs, this.tabController, required this.pages})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AppTabBarState();
}

class AppTabBarState extends State<AppTabBar> {
  @override
  Widget build(BuildContext context) {
    return isAppStyleMaterial()
        ? Center(
            child: Column(
            children: [
              SizedBox(
                height: 60,
                child: TabBar(
                  controller: widget.tabController,
                  tabs: [
                    for (var i in widget.tabs)
                      Tab(
                        icon: Icon(
                          i.icon,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        child: Text(
                          i.text,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                        ),
                      )
                  ],
                ),
              ),
              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  controller: widget.tabController,
                  children: [...widget.pages],
                ),
              ),
            ],
          ))
        : CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                for (var i in widget.tabs)
                  BottomNavigationBarItem(icon: Icon(i.icon), label: i.text)
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              return widget.pages[index];
            });
  }
}

class AppTab {
  final String text;
  final IconData? icon;
  final ValueKey key;

  const AppTab({required this.key, required this.text, this.icon});
}

// Tab(
// icon: Icon(
// Icons.directions_car,
// ),
// ),
// Tab(
// icon: Icon(
// Icons.directions_car,
// ),
// ),
// Tab(
// icon: Icon(
// Icons.directions_car,
// ),
// ),

// Main Screen
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(), // see the HomeTab class below
    const SettingTab() // see the SettingsTab class below
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Kindacode.com'),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
    );
  }
}

// Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Tab'),
    );
  }
}

// Settings Tab
class SettingTab extends StatelessWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Tab'),
    );
  }
}
