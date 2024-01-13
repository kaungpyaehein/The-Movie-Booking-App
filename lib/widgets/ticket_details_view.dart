//ticket details view
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/login_page.dart';

import '../pages/checkout_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class TicketDetailsView extends StatelessWidget {
  final bool isTicketCancelButtonRed;
  const TicketDetailsView({
    super.key,
    required this.isTicketCancelButtonRed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: kMarginLarge, vertical: kMarginMedium4),
      padding: const EdgeInsets.symmetric(vertical: kMarginMedium4),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kTicketGradientStartColor,
              kTicketGradientEndColor,
              kTicketGradientStartColor
            ],
          ),
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //movie info view
          const TicketTopView(),
          const TickerDividerView(),
          TicketBottomView(
            isTicketRed: isTicketCancelButtonRed,
          ),
        ],
      ),
    );
  }
}

class TicketBottomView extends StatelessWidget {
  final bool isTicketRed;
  const TicketBottomView({
    super.key,
    required this.isTicketRed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //convenience fee text
          ConvenienceFeeView(
            label: "Convenience fee",
            price: "500",
            isShow: false,
            onTap: () {},
          ),

          const SizedBox(
            height: kMarginMedium4,
          ),

          //ticket cancelling policy view
          TicketCancellationPolicyView(
            isRed: isTicketRed,
          ),

          //divider
          const Padding(
            padding: EdgeInsets.only(top: kMargin30, bottom: kMarginMedium4),
            child: Divider(
              thickness: 0.5,
            ),
          ),

          const Row(
            children: [
              Text(
                "Total",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: kText18),
              ),

              //spacer
              Spacer(),
              Text(
                "22500Ks",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: kText18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TicketCancellationPolicyView extends StatelessWidget {
  final bool isRed;
  const TicketCancellationPolicyView({
    super.key,
    required this.isRed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTicketCancellationPolicy(context);
      },
      child: Container(
        height: kMargin30,
        padding: const EdgeInsets.symmetric(
            horizontal: kMarginMedium2, vertical: kMarginSmall),
        decoration: BoxDecoration(
            color: isRed ? kCancelButtonColor : kTicketCancellingButtonColor,
            borderRadius: BorderRadius.circular(kMarginMedium4)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: kMarginSmall,
            ),
            Text(
              "Ticket Cancellation policy",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

void showTicketCancellationPolicy(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(kMarginMedium4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ticket Cancellation Policy",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            //spacer
            const SizedBox(
              height: kMarginLarge,
            ),

            Row(
              children: [
                Image.asset(
                  kSnackIcon,
                  height: kMargin30,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: kMarginMedium2,
                ),
                const Text(
                  "100% Refund on F&B",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: kTextRegular2X,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: kMarginLarge,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  kTicketIcon,
                  height: kMargin30,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: kMarginMedium2,
                ),
                const Text(
                  "Up to 75% Refund for Tickets",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: kTextRegular2X,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kMarginLarge,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: kMarginXLarge2,
              ),
              child: Text(
                "-75% refund until 2 hours before show start time",
                style: TextStyle(
                  color: kNowPlayingAndComingSoonSelectedTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: kMarginMedium2,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: kMarginXLarge2,
              ),
              child: Text(
                "-50% refund between 2 hours and 20 minutes before show start time",
                softWrap: true,
                style: TextStyle(
                  color: kNowPlayingAndComingSoonSelectedTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: kMarginXLarge2,
            ),

            const Text(
              "Refund not available for"
              " Convenience fees,Vouchers, Gift Cards, Taxes etc.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kMarginMedium4,
            ),
            const Text(
              "Refund not available for"
              " Convenience fees,Vouchers, Gift Cards, Taxes etc.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kMarginXLarge,
            ),

            CloseButtonView()
          ],
        ),
      );
    },
  );
}

class CloseButtonView extends StatelessWidget {
  const CloseButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, kMargin50),
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kMarginMedium))),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        "Close",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: kTextRegular2X,
        ),
      ),
    );
  }
}

class TickerDividerView extends StatelessWidget {
  const TickerDividerView({
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
            height: 40,
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
            height: 40,
          ),
        ],
      ),
    );
  }
}

class TicketTopView extends StatefulWidget {
  const TicketTopView({
    super.key,
  });

  @override
  State<TicketTopView> createState() => _TicketTopViewState();
}

class _TicketTopViewState extends State<TicketTopView> {
  bool showSnackItems = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //movie name
          const Text(
            "Black Widow (3D) (U/A)",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kText18),
          ),

          //spacer
          const SizedBox(
            height: kMarginMedium2,
          ),

          //cinema name
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: "JCGV : Junction City ",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: kTextRegular2X,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: "(SCREEN 2)",
                style: TextStyle(
                    color: kFacilityViewColor,
                    fontSize: kTextRegular2X,
                    fontWeight: FontWeight.w400)),
          ])),

          //spacer
          const SizedBox(
            height: kMargin30,
          ),

          //date/ time and location view
          const DateTimeLocationView(),
          //spacer
          const SizedBox(
            height: kMarginMedium4,
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
          const SizedBox(
            height: kMarginMedium2,
          ),

          //seats and prices
          const Row(
            children: [
              Text(
                "Gold-G8,G7",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: kTextRegular2X),
              ),

              //spacer
              Spacer(),
              Text(
                "20000Ks",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: kTextRegular2X),
              ),
            ],
          ),
          //divider
          const Padding(
            padding:
                EdgeInsets.only(top: kMarginMedium3, bottom: kMarginMedium4),
            child: Divider(
              thickness: 0.5,
            ),
          ),

          //snacks and prices
          FoodAndBeverageView(
            label: "Food and Beverage",
            price: "20000",
            onTap: () {
              setState(() {
                showSnackItems = !showSnackItems;
              });
            },
            isShow: showSnackItems,
          ),

          //snack items view
          Visibility(
            visible: showSnackItems,
            child: const SnackItemsListView(),
          )
        ],
      ),
    );
  }
}

// convenience fee view
class ConvenienceFeeView extends StatelessWidget {
  final String label;
  final String price;
  final void Function() onTap;
  final bool isShow;
  const ConvenienceFeeView({
    super.key,
    required this.label,
    required this.price,
    required this.onTap,
    required this.isShow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextRegular2X),
          ),
          const SizedBox(
            width: kMargin5,
          ),
          Icon(
            isShow
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.white,
          ),
          //spacer
          const Spacer(),
          Text(
            "${price}Ks",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextRegular2X),
          ),
        ],
      ),
    );
  }
}

class DateTimeLocationView extends StatelessWidget {
  const DateTimeLocationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: kPrimaryColor,
            ),
            //spacer
            SizedBox(
              height: kMarginMedium2,
            ),
            Text(
              "Sat, 18 Jun, 2022",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.access_time,
              color: kPrimaryColor,
            ),
            //spacer
            SizedBox(
              height: kMarginMedium2,
            ),
            Text(
              "3:30PM",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: kPrimaryColor,
            ),
            //spacer
            SizedBox(
              height: kMarginMedium2,
            ),
            Text(
              "Q5H3+JPP, Corner\n of, Bogyoke Lann,\n Yangon ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: kTextSmall),
            ),
          ],
        ),
      ],
    );
  }
}

class SnackItemsListView extends StatelessWidget {
  const SnackItemsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: kMarginMedium),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(top: kMarginMedium3),
        child: SnackItemPriceView(name: "Potato Chips (Qt. 1)", price: "1000"),
      ),
    );
  }
}

//snack price view
class SnackItemPriceView extends StatelessWidget {
  final String name;
  final String price;
  const SnackItemPriceView({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.cancel_presentation_rounded,
          color: kPrimaryColor,
        ),
        const SizedBox(
          width: kMarginMedium,
        ),
        Text(
          name,
          style: const TextStyle(
              color: kNowPlayingAndComingSoonSelectedTextColor,
              fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        Text(
          "${price}Ks",
          style: const TextStyle(
              color: kNowPlayingAndComingSoonSelectedTextColor,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

//food and beverage view
class FoodAndBeverageView extends StatelessWidget {
  final String label;
  final String price;
  final bool isShow;
  final void Function() onTap;
  const FoodAndBeverageView({
    super.key,
    required this.label,
    required this.price,
    required this.isShow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          //food and beverages title
          Image.asset(
            kSnackIcon,
            height: kMarginMedium4,
            width: kMarginMedium4,
            color: Colors.white,
          ),
          const SizedBox(
            width: kMargin5,
          ),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextRegular2X),
          ),
          const SizedBox(
            width: kMargin5,
          ),
          Icon(
            isShow
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.white,
          ),

          //spacer
          const Spacer(),
          //price
          Text(
            price,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextRegular2X),
          ),
        ],
      ),
    );
  }
}
