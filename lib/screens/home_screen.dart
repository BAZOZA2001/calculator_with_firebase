import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_app/screens/sign_in_screen.dart';
import 'package:calculator_app/screens/sign_up_screen.dart';
import 'package:calculator_app/screens/calculator_screen.dart';
import 'package:calculator_app/services/theme_service.dart';
import 'package:calculator_app/widgets/custom_drawer.dart';
import 'package:calculator_app/services/connectivity_service.dart';
import 'package:calculator_app/services/battery_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    SignInScreen(),
    SignUpScreen(),
    CalculatorScreen()
  ];

  @override
  void initState() {
    super.initState();
    ConnectivityService();
    BatteryService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onItemTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.pop(context);
        },
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
      ),
    );
  }
}
