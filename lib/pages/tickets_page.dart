import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/ticket_details_page.dart';
import 'package:the_movie_booking_app/widgets/ticket_view.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: kBackgroundColor,
          foregroundColor: kWhiteColor,
          actions: const [
            Icon(
              Icons.search,
              color: Colors.white,
              size: kMarginLarge,
            ),
            SizedBox(
              width: kMarginXLarge,
            ),
            Icon(
              Icons.notifications,
              color: Colors.white,
              size: kMarginLarge,
            ),
            SizedBox(
              width: kMarginXLarge,
            ),
            Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: kMarginLarge,
            ),
            SizedBox(
              width: kHomeScreenAppBarRightMargin,
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium4, horizontal: kMarginMedium4),
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: kMargin30),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicketDetailsPage(),
                      ));
                },
                child:  Container(

                )),
          ),
        ));
  }
}
