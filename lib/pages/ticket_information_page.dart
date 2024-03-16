import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';
import 'package:the_movie_booking_app/network/requests/checkout_request.dart';
import 'package:the_movie_booking_app/pages/main_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../widgets/ticket_view.dart';

class TicketInformationPage extends StatefulWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  final int paymentId;
  final MovieVO movieVO;
  final CheckoutVO checkoutVO;
  const TicketInformationPage(
      {super.key,
      required this.selectedSeatList,
      required this.totalSeatPrice,
      required this.date,
      required this.timeslotVO,
      required this.snackList,
      required this.cinemaName,
      required this.paymentId,
      required this.movieVO,
      required this.checkoutVO});

  @override
  State<TicketInformationPage> createState() => _TicketInformationPageState();
}

class _TicketInformationPageState extends State<TicketInformationPage> {
  bool isShow = true;

  final MovieBookingModel model = MovieBookingModel();

  CheckoutVO? checkoutVO;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {
        isShow = false;
      });
      // var request = CheckoutRequest(
      //   bookingDate: widget.date,
      //   cinemaDayTimeslotId: widget.timeslotVO.cinemaDayTimeslotId,
      //   movieId: widget.movieVO.id,
      //   paymentTypeId: widget.paymentId,
      //   seatNumber: formatSeats(),
      //   snacks: widget.snackList,
      // );
      // model.checkout(request)?.then((response) {
      //   setState(() {
      //     checkoutVO = response;
      //   });
      // }).catchError((error) {
      //   ///catch the error and
      //   /// show custom error
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       content: Text(error.toString()),
      //     ),
      //   );
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutVO checkoutVO = widget.checkoutVO;
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
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kMargin30, horizontal: kMarginLarge),
            child: checkoutVO == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      //ticket view
                      TicketView(
                        selectedSeatList: widget.selectedSeatList,
                        totalSeatPrice: widget.totalSeatPrice,
                        date: widget.date,
                        timeslotVO: widget.timeslotVO,
                        snackList: widget.snackList,
                        cinemaName: widget.cinemaName,
                        paymentId: widget.paymentId,
                        movieVO: widget.movieVO,
                        checkoutVO: checkoutVO!,
                      ),

                      //spacer
                      const Spacer(),

                      //qr view
                      QRView(
                        checkoutVO: checkoutVO!,
                      ),
                      //spacer
                      const Spacer(),

                      //done button
                      const DoneButtonView(),

                      //spacer
                      const Spacer(),
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
  final CheckoutVO checkoutVO;
  const QRView({
    super.key,
    required this.checkoutVO,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // QrImageView(
        //   foregroundColor: Colors.white,
        //   padding: EdgeInsets.zero,
        //   backgroundColor: Colors.transparent,
        //   data: '1234567890',
        //   version: QrVersions.auto,
        //   size: kQRSize,
        // ),
        Image.network(
          checkoutVO.getQRImage(),
          height: kQRSize,
          width: kQRSize,
        ),
        //spacer
        const SizedBox(
          height: kMarginMedium4,
        ),
        Text(
          checkoutVO.bookingNo ?? "",
          style: const TextStyle(
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
