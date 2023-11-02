import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/components/maps.dart';
import 'package:projeto_flutter_mylink/components/update.dart';
import 'package:projeto_flutter_mylink/controllers/sharedpreferences.controller.dart';
import 'package:projeto_flutter_mylink/routes/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List screens = [const Maps(), const UpdateComponent(), const WelcomePage()];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 2) {
      await exit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Perfil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: "Exit",
            ),
          ],
        ),
      ),
    );
  }
}
