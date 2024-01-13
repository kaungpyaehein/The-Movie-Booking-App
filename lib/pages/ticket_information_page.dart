import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/main_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';

import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../widgets/ticket_view.dart';
import 'checkout_page.dart';

class TickerInformationPage extends StatelessWidget {
  const TickerInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: kBackgroundColor,
        title: const Text(
          kTickerInformationText,
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular3X,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            vertical: kMargin30, horizontal: kMarginLarge),
        child: Column(
          children: [
            //ticket view
            TicketView(),

            //spacer
            Spacer(),

            //qr view
            QRView(),
            //spacer
            Spacer(),

            //done button
            DoneButtonView(),
            
            //spacer
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class DoneButtonView extends StatelessWidget {
  const DoneButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          minimumSize: const Size(kDoneButtonWidth, kMarginXXLarge),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kMarginSmall))),
      onPressed: () {
       Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>
         const MainPage(),) ,(route) => false) ;
      },
      child: const Text(
        "Done",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: kTextRegular3X),
      ),
    );
  }
}

class QRView extends StatelessWidget {
  const QRView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QrImageView(
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          data: '1234567890',
          version: QrVersions.auto,
          size: kQRSize,
        ),
        //spacer
        const SizedBox(
          height: kMarginMedium4,
        ),
        const Text(
          "WAG5LP1C",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular3X,
              fontWeight: FontWeight.w700),
        ),
        RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: "TPIN:",
              style: TextStyle(
                  color: kNowPlayingAndComingSoonSelectedTextColor,
                  fontSize: kTextRegular3X,
                  fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: "WAG5LP1C",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kTextRegular3X,
                  fontWeight: FontWeight.w700),
            )
          ]),
        )
      ],
    );
  }
}




