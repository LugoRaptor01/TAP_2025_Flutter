import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/global_values.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc'),
            ),
            accountName: Text('Yo mero'),
            accountEmail: Text('yomero@gmail.com')
          );
        },
        extendedTheme: const SidebarXTheme(
          width: 250
        ),
        /*extendedTheme: const SidebarXTheme(
          width: 200
        ),*/
        controller: SidebarXController(selectedIndex: 0, extended: true),
        items: [
          SidebarXItem(
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/chall');
            },
            icon: Icons.home, label: 'Challenge 1'),
            SidebarXItem(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/api');

        },
        icon: Icons.movie, label: 'Popular Movies'
      )
        ],
      ),
      appBar: AppBar(
        title: Text('Panel de Control'),
      ),
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        body: const Center(
          child: Text('Si')
        ),
        items:[
          HawkFabMenuItem(
            label: 'Modo N',
            ontap: () => GlobalValues.themeMode.value = 0,
            icon: const Icon(Icons.light_mode)
          ),
          HawkFabMenuItem(
            label: 'Modo Flashbang',
            ontap: () => GlobalValues.themeMode.value = 1,
            icon: const Icon(Icons.dark_mode)
          ),
          HawkFabMenuItem(
            label: 'Modo Warm',
            ontap: () => GlobalValues.themeMode.value = 2,
            icon: const Icon(Icons.hot_tub)
          )
        ]
      ),
    );
  }
}