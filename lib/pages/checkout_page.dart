import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/pages/snack_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../utils/dimensions.dart';
import '../widgets/ticket_details_view.dart';

class CheckoutPage extends StatelessWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  const CheckoutPage(
      {super.key,
      required this.selectedSeatList,
      required this.totalSeatPrice,
      required this.date,
      required this.timeslotVO,
      required this.snackList, required this.cinemaName});

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
             SingleChildScrollView(
              child: TicketDetailsView(
                isTicketCancelButtonRed: false,
                date: date,
                totalSeatPrice: totalSeatPrice,
                selectedSeatList: selectedSeatList,
                snackList: snackList,
                timeslotVO: timeslotVO,
                cinemaName: cinemaName,

              ),
            ),

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
