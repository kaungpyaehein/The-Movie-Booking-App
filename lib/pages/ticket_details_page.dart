import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';
import 'package:the_movie_booking_app/widgets/ticket_details_view.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import 'movie_details_page.dart';

class TicketDetailsPage extends StatelessWidget {
  const TicketDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kBackgroundColor,
        title: const Text(
          kTicketDetailsText,
          style: TextStyle(
              color: Colors.white,
              fontSize: kAppBarTitleFontSize,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: const Stack(
        children: [
          //ticket details
          SingleChildScrollView(child: TicketDetailsView(
            isTicketCancelButtonRed: true,
          )),

          //bottom view
          TicketDetailsBottomView(),
        ],
      ),
    );
  }
}

class TicketDetailsBottomView extends StatelessWidget {
  const TicketDetailsBottomView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: kMarginLarge),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, kBackgroundColor])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  kRefundAmountText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: kTextRegular2X,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "15000KS",
                  style: TextStyle(
                      color: kCancelButtonColor,
                      fontSize: kTextRegular3X,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),

            //spacer
            const SizedBox(
              width: kMarginLarge,
            ),
            CancelButton(
              label: kCancelBookingLabel,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//booking button
class CancelButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  const CancelButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.52,
      height: kBookingButtonHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              kBookingButtonEnd,
              color: kCancelButtonColor,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              kBookingButtonEnd,
              color: kCancelButtonColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: kBookingButtonHeight,
                decoration: const BoxDecoration(color: kCancelButtonColor),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
