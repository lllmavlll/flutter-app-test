import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    // to check if the current route is the same as the route to navigate to
    void checkRoute(String route, dynamic arguments) {
      if (currentRoute == route) {
        return;
      } else {
        Navigator.pushNamed(context, route, arguments: arguments);
      }
    }

    return AppBar(
      automaticallyImplyLeading: false,
      title: TextButton(
        onPressed: () {
          checkRoute('/', null);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Interstellar',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      actions: currentRoute == '/'
          ? []
          : [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.water_sharp),
                    color: currentRoute == '/page2'
                        ? Colors.white
                        : Colors.white70,
                    onPressed: () => checkRoute('/page2', {
                      'name': 'Maverick',
                      'email': 'maverick@gmail.com',
                      'password': '123456',
                      'gender': 'Male',
                      'status': 'Inactive',
                      'isChecked': true,
                      'sliderValue': 0.5,
                      'phone': '1234567890',
                    }),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    color: currentRoute == '/page3'
                        ? Colors.white
                        : Colors.white70,
                    onPressed: () => checkRoute('/page3', null),
                  ),
                ],
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
