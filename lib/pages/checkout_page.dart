import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/pages/snack_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../data/vos/movie_vo.dart';
import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../utils/dimensions.dart';
import '../widgets/ticket_details_view.dart';

class CheckoutPage extends StatefulWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  final MovieVO movieVO;
  const CheckoutPage(
      {super.key,
      required this.selectedSeatList,
      required this.totalSeatPrice,
      required this.date,
      required this.timeslotVO,
      required this.snackList,
      required this.cinemaName,
      required this.movieVO});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<SnackVO> snackList = [];

  @override
  void initState() {
    snackList = widget.snackList;
    super.initState();
  }

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
                date: widget.date,
                totalSeatPrice: widget.totalSeatPrice,
                selectedSeatList: widget.selectedSeatList,
                snackList: snackList,
                timeslotVO: widget.timeslotVO,
                cinemaName: widget.cinemaName,
                onDeleteSnack: (snackVO) {
                  setState(() {
                    snackList.remove(snackVO);
                  });
                },
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
                          builder: (context) => PaymentPage(
                            selectedSeatList: widget.selectedSeatList,
                            totalSeatPrice: widget.totalSeatPrice,
                            date: widget.date,
                            timeslotVO: widget.timeslotVO,
                            snackList: snackList,
                            cinemaName: widget.cinemaName,
                            movieVO: widget.movieVO,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
