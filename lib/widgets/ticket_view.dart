//ticket view
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/widgets/ticket_details_view.dart';

import '../pages/checkout_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class TicketView extends StatelessWidget {
  const TicketView({super.key});

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
      child: const Column(
        children: [
          //ticket top view
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kMarginMedium3,
            ),
            child: Row(
              children: [
                //ticket poster
                TicketPosterView(),

                //spacer
                SizedBox(
                  width: kMarginMedium4,
                ),

                //ticket information
                SmallTicketInformationView()
              ],
            ),
          ),

          //ticket divider
          TicketSmallDivider(),

          //ticket bottom view
          DateTimeLocationView(),
        ],
      ),
    );
  }
}

class TicketPosterView extends StatelessWidget {
  const TicketPosterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kMarginSmall),
      child: Image.asset(
        "assets/images/poster4.jpg",
        height: kTicketViewImageHeight,
        width: kTicketViewImageWidth,
        fit: BoxFit.cover,
      ),
    );
  }
}

class SmallTicketInformationView extends StatelessWidget {
  const SmallTicketInformationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //movie name
          const Text(
            "Black Widow (3D) (U/A)",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kText18),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),
          //spacer
          const Text(
            "JCGV : Junction City",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: kTextRegular2X,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: kMarginMedium3,
          ),
          //tickets price view
          RichText(
              text: const TextSpan(children: [
            TextSpan(
              text: "M-Ticket(",
              style: TextStyle(
                color: kFacilityViewColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: "2",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
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
              text: const TextSpan(children: [
            TextSpan(
              text: "Gold-G8,G7",
              style: TextStyle(
                color: Colors.white,
                fontSize: kTextRegular2X,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: "(Screen2)",
              style: TextStyle(
                fontSize: kTextSmall,
                color: kFacilityViewColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ])),
        ],
      ),
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
