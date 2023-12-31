import 'package:flutter/material.dart';

class ButtonNavigator extends StatelessWidget {
  const ButtonNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0XFFD3D3D3),
      elevation: 10,
      onTap: (_) {},
      items: [
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 197, 192, 192).withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.home,
              color: Color(0XFF28A4DC),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.task_alt_sharp),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.bar_chart),
        ),
      ],
    );
  }
}