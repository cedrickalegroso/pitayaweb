import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pitaya_web/screens/auth/login.dart';
import 'package:pitaya_web/screens/dash/dashboard.dart';
import 'package:pitaya_web/screens/dash/edit.dart';
import 'package:pitaya_web/screens/dash/test.dart';

import 'package:pitaya_web/services/auth.dart';
import 'package:pitaya_web/services/clipper.dart';
import 'package:pitaya_web/services/database.dart';
import 'package:pitaya_web/services/models.dart';
import 'package:provider/provider.dart';

class DashboardItems {
  const DashboardItems(this.label, this.icon, this.selectedIcon, this.page);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final Widget page;
}

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

const List<DashboardItems> destinations = <DashboardItems>[
  DashboardItems('Dashboard', Icon(Icons.dashboard_outlined),
      Icon(Icons.dashboard), DashboardPageMain()),
  DashboardItems('Add ', Icon(Icons.add), Icon(Icons.add), CreateNew()),
  DashboardItems('Edit ', Icon(Icons.edit), Icon(Icons.edit), EditPrev()),
];

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboard> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  bool isExtended = false;

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Page Index =  $screenIndex'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: destinations.map(
          (DashboardItems destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isExtended = isExtended ? false : true;
                });
              },
              child: NavigationRail(
                backgroundColor: const Color(0xFF1B76CB),
                indicatorColor: const Color(0xFF11D9D0),
                selectedIconTheme:
                    const IconThemeData(color: Color(0xFFFFFFFF)),
                unselectedIconTheme:
                    const IconThemeData(color: Color(0xFFFFFFFF)),
                unselectedLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal),
                selectedLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
                extended: isExtended,
                minWidth: 80,
                destinations: destinations.map(
                  (DashboardItems destination) {
                    return NavigationRailDestination(
                      label: Text(destination.label),
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                    );
                  },
                ).toList(),
                selectedIndex: screenIndex,
                useIndicator: true,
                onDestinationSelected: (int index) async {
                  setState(() {
                    screenIndex = index;
                  });
                },
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: destinations[screenIndex].page,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    final firebaseuser = FirebaseAuth.instance.currentUser;

    return firebaseuser != null
        ? MultiProvider(
            providers: [
              StreamProvider<List<Descriptions>>.value(
                value: DatabaseService(uid: firebaseuser.uid).alldescriptions,
                initialData: [],
              ),
            ],
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Pitaya Clinic Web Portal'),
                  actions: <Widget>[
                    PopupMenuButton<SampleItem>(
                      padding: const EdgeInsets.all(100),
                      offset: const Offset(3000, 50),
                      initialValue: selectedMenu,
                      // Callback that sets the selected popup menu item.
                      onSelected: (SampleItem item) {
                        setState(() {
                          selectedMenu = item;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem>>[
                        PopupMenuItem<SampleItem>(
                          child: const Text('Logout'),
                          onTap: () async {
                            await context.read<AuthService>().signout().then(
                                (value) =>
                                    Navigator.pushNamed(context, '/log'));
                          },
                        ),
                      ],
                      child: SizedBox(
                        width: 150,
                        child: Row(children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Text(firebaseuser.displayName!),
                        ]),
                      ),
                    ),
                  ],
                ),
                body: showNavigationDrawer
                    ? buildDrawerScaffold(context)
                    : buildBottomBarScaffold()),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Color(0xff117AFF),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                  ],
                ))
              ],
            ),
          );
  }
}
