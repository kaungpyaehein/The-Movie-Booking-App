import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/widgets/cinemas_view.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class CinemasPage extends StatelessWidget {
  const CinemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
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
        body: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium, vertical: kMarginMedium),
          itemBuilder: (context, index) {
            print("is building");
            return const Padding(
              padding: EdgeInsets.only(bottom: kMarginSmall),
              child: CinemasView(
                isShow: false,
              ),
            );
          },
        ));
  }
}
