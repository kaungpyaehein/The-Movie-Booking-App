import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../utils/dimensions.dart';
import '../widgets/ticket_details_view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          title: const Text(
            kCheckoutText,
            style: TextStyle(
                color: Colors.white,
                fontSize: kAppBarTitleFontSize,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Stack(
          children: [
            //ticket details
            const SingleChildScrollView(child: TicketDetailsView(
              isTicketCancelButtonRed: false,
            )),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 180,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, kBackgroundColor])),
                child: Center(
                  child: PrimaryButton(
                    label: kBookingLabel,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ));
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
