import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Text(
          "Tickets Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
