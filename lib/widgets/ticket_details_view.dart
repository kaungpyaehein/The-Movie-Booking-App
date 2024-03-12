//ticket details view

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../pages/snack_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class TicketDetailsView extends StatelessWidget {
  final bool isTicketCancelButtonRed;
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  const TicketDetailsView({
    super.key,
    required this.isTicketCancelButtonRed,
    required this.selectedSeatList,
    required this.totalSeatPrice,
    required this.date,
    required this.timeslotVO,
    required this.snackList,
    required this.cinemaName,
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
          TicketTopView(
            timeslotVO: timeslotVO,
            totalSeatPrice: totalSeatPrice,
            date: date,
            selectedSeatList: selectedSeatList,
            cinemaName: cinemaName,
            snackList: snackList,
          ),
          const TicketDividerView(),
          TicketBottomView(
            isTicketRed: isTicketCancelButtonRed,
            totalAmount: getTotalCheckoutAmount(snackList, totalSeatPrice),
          ),
        ],
      ),
    );
  }
}

String getTotalCheckoutAmount(
  List<SnackVO> snackList,
  String totalSeatCost,
) {
  return (int.parse(getTotalSnackAmount(snackList)) +
          5 +
          int.parse(totalSeatCost))
      .toString();
}

class TicketBottomView extends StatelessWidget {
  final bool isTicketRed;
  final String totalAmount;
  const TicketBottomView({
    super.key,
    required this.isTicketRed,
    required this.totalAmount,
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
            price: "5",
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

          Row(
            children: [
              const Text(
                "Total",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: kText18),
              ),

              //spacer
              const Spacer(),
              Text(
                "$totalAmount Ks",
                style: const TextStyle(
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
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.6,
        child: Container(
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

              const CloseButtonView()
            ],
          ),
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

class TicketDividerView extends StatelessWidget {
  const TicketDividerView({
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
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final String cinemaName;
  final List<SnackVO> snackList;
  const TicketTopView({
    super.key,
    required this.selectedSeatList,
    required this.totalSeatPrice,
    required this.date,
    required this.timeslotVO,
    required this.cinemaName,
    required this.snackList,
  });

  @override
  State<TicketTopView> createState() => _TicketTopViewState();
}

class _TicketTopViewState extends State<TicketTopView> {
  bool showSnackItems = false;
  String getAllSeats() {
    return widget.selectedSeatList.map((seat) => seat.seatName!).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //movie name
          Text(
            "${widget.cinemaName} (3D) (U/A)",
            style: const TextStyle(
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
          DateTimeLocationView(
            date: widget.date,
            timeslotVO: widget.timeslotVO,
          ),
          //spacer
          const SizedBox(
            height: kMarginMedium4,
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
              text: widget.selectedSeatList.length.toString(),
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
          const SizedBox(
            height: kMarginMedium2,
          ),

          //seats and prices
          Row(
            children: [
              Expanded(
                child: Text(
                  "Normal- ${getAllSeats()}",
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: kTextRegular2X),
                ),
              ),

              //spacer

              Text(
                "${widget.totalSeatPrice} Ks",
                style: const TextStyle(
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
            onTap: () {
              setState(() {
                showSnackItems = !showSnackItems;
              });
            },
            isShow: showSnackItems,
            snacks: widget.snackList,
          ),

          //snack items view
          Visibility(
            visible: showSnackItems && widget.snackList.isNotEmpty,
            child: SnackItemsListView(
              snackList: widget.snackList,
            ),
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

String formatDate(String inputDate) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd");
  DateTime date = inputFormat.parse(inputDate);
  DateFormat outputFormat = DateFormat("d MMM, yyyy");
  String formattedDate = outputFormat.format(date);

  return formattedDate;
}

class DateTimeLocationView extends StatelessWidget {
  final String date;
  final TimeslotVO timeslotVO;
  const DateTimeLocationView({
    super.key,
    required this.date,
    required this.timeslotVO,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: kPrimaryColor,
            ),
            //spacer
            const SizedBox(
              height: kMarginMedium2,
            ),
            Text(
              formatDate(date),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              Icons.access_time,
              color: kPrimaryColor,
            ),
            //spacer
            const SizedBox(
              height: kMarginMedium2,
            ),
            Text(
              timeslotVO.startTime.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const Column(
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
  final List<SnackVO> snackList;
  const SnackItemsListView({
    super.key,
    required this.snackList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: kMarginMedium),
        shrinkWrap: true,
        itemCount: snackList.length,
        itemBuilder: (context, index) {
          final SnackVO snackVO = snackList[index];
          return Padding(
            padding: const EdgeInsets.only(top: kMarginMedium3),
            child: SnackItemPriceView(
                name: "${snackVO.name} ${snackVO.quantity}",
                price: "${snackVO.price! * snackVO.quantity}"),
          );
        });
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

  final bool isShow;
  final List<SnackVO> snacks;
  final void Function() onTap;
  const FoodAndBeverageView({
    super.key,
    required this.label,
    required this.isShow,
    required this.onTap,
    required this.snacks,
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
            snacks.isEmpty
                ? "0"
                : "${getTotalSnackAmount(snacks).toString()} Ks",
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
