import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Text(
          "Cinema Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
