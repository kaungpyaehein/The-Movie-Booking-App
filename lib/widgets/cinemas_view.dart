//time view
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/cinema_details_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';


import '../data/sample_vos/time_slot_data_list.dart';
import '../data/sample_vos/time_slot_model.dart';
import '../pages/seating_plan_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class CinemasView extends StatefulWidget {
  final bool isShow;
  const CinemasView({super.key, required this.isShow});

  @override
  State<CinemasView> createState() => _CinemasViewState();
}

class _CinemasViewState extends State<CinemasView> {
  bool isShow = false;
  @override
  void initState() {
    isShow = widget.isShow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShow = !isShow;
        });
      },
      child: Column(
        children: [
          //cinema name and details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "JCGV : Junction City",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: kTextRegular2X,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CinemaDetailsPage(),
                          ));
                    },
                    child: const Text(
                      kSeeDetailsLabel,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: kTextRegular2X,
                          decorationColor: kPrimaryColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: kMarginMedium4,
          ),
          //facility view
          const FacilityView(),
          const SizedBox(
            height: kMargin18,
          ),
          Visibility(
              visible: isShow,
              //time slot view
              child: const TimeSlotsView()),
          const Divider()
        ],
      ),
    );
  }
}

class TimeSlotsView extends StatelessWidget {
  const TimeSlotsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kMarginLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: timeSlotDataList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: kMarginMedium4,
                crossAxisSpacing: kMarginXLarge,
              ),
              itemBuilder: (context, index) {
                final data = timeSlotDataList[index];
                return TimeSlotItem(
                  timeSlotModel: data,
                );
              }),
          // Wrap(
          //     spacing: kMarginXLarge,
          //     runSpacing: kMarginLarge,
          //     alignment: WrapAlignment.start,
          //     crossAxisAlignment: WrapCrossAlignment.center,
          //     children: timeSlotDataList.map((data) {
          //       return TimeSlotItem(timeSlotModel: data);
          //     }).toList()),
          // const SizedBox(
          //   height: kMarginLarge,
          // ),
          const SizedBox(
            height: kMarginMedium3,
          ),
          const Row(
            children: [
              Icon(
                Icons.info,
                color: kFacilityViewColor,
              ),
              SizedBox(
                width: kMargin5,
              ),
              Text(
                "Long press on show timing to see seat class!",
                style: TextStyle(
                    color: kFacilityViewColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: kMarginMedium3,
          ),
        ],
      ),
    );
  }
}

//time slot item view
class TimeSlotItem extends StatelessWidget {
  final TimeSlotModel timeSlotModel;

  const TimeSlotItem({super.key, required this.timeSlotModel});
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    late Color borderColor;
    late Color backgroundColor;

    switch (timeSlotModel.status) {
      case "Unavailable":
        textColor = kBottomNavigationUnselectedColor;
        backgroundColor = kTimeSlotCardUnavailableBackgroundColor;
        borderColor = kBottomNavigationUnselectedColor;
        break;
      case "Available":
        backgroundColor = kTimeSlotCardAvailableBackgroundColor;
        borderColor = kAvailableColor;
        break;

      case "Filling Fast":
        backgroundColor = kTimeSlotCardFillingFastBackgroundColor;
        borderColor = kFillingFastColor;
        break;

      case "Almost Full":
        backgroundColor = kTimeSlotCardAlmostFullBackgroundColor;
        borderColor = kAlmostFullColor;
        break;

      default:
        break;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SeatingPlanPage(),
            ));
      },
      child: Container(
        width: kTimeSlotCardWidth + 10,
        height: kTimeSlotCardHeight,
        padding: const EdgeInsets.symmetric(
            horizontal: kTimeSlotItemPaddingHorizontal,
            vertical: kTimeSlotItemPaddingVertical),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(kMarginSmall),
            border: Border.all(color: borderColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              timeSlotModel.time,
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              timeSlotModel.type,
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              timeSlotModel.screen,
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            timeSlotModel.seats != 0
                ? Text(
                    "${timeSlotModel.seats}",
                    style: TextStyle(
                      color: textColor,
                      fontSize: kTextSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class FacilityView extends StatelessWidget {
  const FacilityView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: kMarginLarge,
        ),
        FacilityItemView(
          label: "Parking",
          image: kParkingIcon,
        ),
        SizedBox(
          width: kMarginMedium3,
        ),
        FacilityItemView(
          label: "Online Food",
          image: kFoodIcon,
        ),
        SizedBox(
          width: kMarginMedium3,
        ),
        FacilityItemView(
          label: "Wheel Chair",
          image: kWheelchairIcon,
        ),
      ],
    );
  }
}

class FacilityItemView extends StatelessWidget {
  final String label;
  final String image;
  const FacilityItemView({
    super.key,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: kMarginMedium4,
          width: kMarginMedium4,
        ),
        const SizedBox(
          width: kMargin5,
        ),
        Text(
          label,
          style: const TextStyle(
              color: kFacilityViewColor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
