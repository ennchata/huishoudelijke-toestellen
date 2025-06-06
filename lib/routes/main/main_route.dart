import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/main/listing/listing_route.dart';
import 'package:flutter_application_1/routes/main/profile/profile_route.dart';
import 'package:flutter_application_1/routes/main/sell/sell_route.dart';
import 'package:flutter_application_1/types/user.dart';

class MainRoute extends StatefulWidget {
  final User user;

  const MainRoute({super.key, required this.user});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.house), label: "Home"),
          NavigationDestination(icon: Icon(Icons.add_home_rounded), label: "Sell Appliance"),
          NavigationDestination(icon: Icon(Icons.person), label: "Manage Profile")
        ],
      ),
      body: <Widget>[
        // Listing
        MainListingRoute(user: widget.user),

        // Sell Appliance
        SellRoute(user: widget.user),

        // Profile
        ProfileRoute(user: widget.user)
      ][pageIndex]
    );
  }
}
