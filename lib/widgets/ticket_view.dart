//ticket view
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/widgets/ticket_details_view.dart';

import '../data/vos/movie_vo.dart';
import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../pages/checkout_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class TicketView extends StatelessWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  final int paymentId;
  final MovieVO movieVO;
  final CheckoutVO checkoutVO;
  const TicketView(
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kMarginMedium3,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kTicketSmallGradientStartColor1,
                kTicketSmallGradientStartColor2,
                kTicketSmallGradientStartColor3,
                kTicketSmallGradientStartColor4,
              ])),
      child: Column(
        children: [
          //ticket top view
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium3,
            ),
            child: Row(
              children: [
                //ticket poster
                TicketPosterView(
                  imageUrl: movieVO.getPosterPathWithBaseUrl(),
                ),

                const SizedBox(
                  width: kMarginMedium4,
                ),

                //ticket information
                Expanded(
                  child: SmallTicketInformationView(
                    checkoutVO: checkoutVO,
                    movieVO: movieVO,
                    cinemaName: cinemaName,
                  ),
                ),
                //spacer
                const SizedBox(
                  width: kMarginMedium4,
                ),
              ],
            ),
          ),

          //ticket divider
          const TicketSmallDivider(),

          //ticket bottom view
          DateTimeLocationView(
            timeslotVO: checkoutVO.timeslot!,
            date: checkoutVO.bookingDate!,
          ),
        ],
      ),
    );
  }
}

class TicketPosterView extends StatelessWidget {
  final String imageUrl;
  const TicketPosterView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(kMarginSmall),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: kTicketViewImageHeight,
          width: kTicketViewImageWidth,
          fit: BoxFit.cover,
        ));
  }
}

class SmallTicketInformationView extends StatelessWidget {
  final CheckoutVO checkoutVO;
  final MovieVO movieVO;
  final String cinemaName;
  const SmallTicketInformationView({
    super.key,
    required this.checkoutVO,
    required this.movieVO,
    required this.cinemaName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //movie name
        Text(
          "${movieVO.title} (3D) (U/A)",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: kText18),
        ),
        const SizedBox(
          height: kMarginMedium2,
        ),
        //spacer
        Text(
          cinemaName,
          style: const TextStyle(
              color: kPrimaryColor,
              fontSize: kTextRegular2X,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: kMarginMedium3,
        ),
        //tickets price view
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: "M-Ticket(",
            style: TextStyle(
              color: kFacilityViewColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: "${checkoutVO.totalSeat}",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(
            text: ")",
            style: TextStyle(
              color: kFacilityViewColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ])),
        //spacer
        const SizedBox(
          height: kMarginMedium2,
        ),

        //seat text
        RichText(
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: [
              TextSpan(
                text: "Normal - ${checkoutVO.seat}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: kTextRegular2X,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(
                text: "(Screen2)",
                style: TextStyle(
                  fontSize: kTextSmall,
                  color: kFacilityViewColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ])),
      ],
    );
  }
}

class TicketSmallDivider extends StatelessWidget {
  const TicketSmallDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMarginMedium2),
      child: Row(
        children: [
          //left ellipse
          Image.asset(
            kEllipseLeftImage,
            height: kMargin30,
          ),
          const Expanded(
            child: Text(
              "--------------------------------------------------------",
              maxLines: 1,
              style: TextStyle(
                  color: kNowPlayingAndComingSoonUnSelectedTextColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Image.asset(
            kEllipseRightImage,
            height: kMargin30,
          ),
        ],
      ),
    );
  }
}
