import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
