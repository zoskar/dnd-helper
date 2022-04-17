import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({
    Key? key,
  }) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {

 

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Character',
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'Combat',
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Spells',
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Rules',
            backgroundColor: Colors.blue),
      ],
    );
  }
}
