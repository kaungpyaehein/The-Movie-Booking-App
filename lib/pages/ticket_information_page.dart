import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_movie_booking_app/pages/main_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../widgets/ticket_view.dart';

class TicketInformationPage extends StatefulWidget {
  const TicketInformationPage({super.key});

  @override
  State<TicketInformationPage> createState() => _TicketInformationPageState();
}

class _TicketInformationPageState extends State<TicketInformationPage> {
  bool isShow = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {
        isShow = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            foregroundColor: Colors.white,
            backgroundColor: kBackgroundColor,
            centerTitle: true,
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
                // booking successful view
              ],
            ),
          ),
        ),
        Visibility(
          visible: isShow,
          child: const Align(
            alignment: Alignment.center,
            child: BookingSuccessfulOverlayView(),
          ),
        )
      ],
    );
  }
}

class BookingSuccessfulOverlayView extends StatelessWidget {
  const BookingSuccessfulOverlayView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      height: double.maxFinite,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8999999761581421),
      ),
      child: Center(
        child: Image.asset(
          kBookingSuccessfulImage,
          width: 350,
          fit: BoxFit.contain,
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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
            (route) => false);
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
