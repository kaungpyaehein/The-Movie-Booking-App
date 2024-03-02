//time view
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/pages/cinema_details_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../data/sample_vos/time_slot_data_list.dart';
import '../data/sample_vos/time_slot_model.dart';
import '../data/vos/cinema_vo.dart';
import '../pages/seating_plan_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class CinemasView extends StatefulWidget {
  final bool isShow;
  final CinemaVO cinemaVO;
  final void Function() onTapTimeslot;
  const CinemasView({super.key, required this.isShow, required this.cinemaVO, required this.onTapTimeslot});

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
      behavior: HitTestBehavior.opaque,
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
                Text(
                  widget.cinemaVO.cinema ?? "",
                  style: const TextStyle(
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
              child:  TimeSlotsView(
                timeslots: widget.cinemaVO.timeslots ?? [] ,
                onTapTimeslot: widget.onTapTimeslot,
              )),
          const Divider()
        ],
      ),
    );
  }
}

class TimeSlotsView extends StatelessWidget {
  final List<TimeslotVO> timeslots;
  final void Function() onTapTimeslot;
  const TimeSlotsView({
    super.key, required this.timeslots, required this.onTapTimeslot,
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
              itemCount: timeslots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: kMarginMedium4,
                crossAxisSpacing: kMarginXLarge,
              ),
              itemBuilder: (context, index) {
                final data = timeslots[index];
                return TimeSlotItem(
                  timeslotVO: data,
                  onTapTimeSlot: onTapTimeslot ,
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
  final TimeslotVO timeslotVO;
  final void Function() onTapTimeSlot;

  const TimeSlotItem({super.key, required this.timeslotVO, required this.onTapTimeSlot});
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    late Color borderColor;
    late Color backgroundColor;

    switch (timeslotVO.status.toString()) {
      case "1":
        textColor = kBottomNavigationUnselectedColor;
        backgroundColor = kTimeSlotCardUnavailableBackgroundColor;
        borderColor = kBottomNavigationUnselectedColor;
        break;
      case "2":
        backgroundColor = kTimeSlotCardAvailableBackgroundColor;
        borderColor = kAvailableColor;
        break;

      case "3":
        backgroundColor = kTimeSlotCardFillingFastBackgroundColor;
        borderColor = kFillingFastColor;
        break;

      case "4":
        backgroundColor = kTimeSlotCardAlmostFullBackgroundColor;
        borderColor = kAlmostFullColor;
        break;

      default:
        break;
    }
    return GestureDetector(
      onTap: onTapTimeSlot,
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
              timeslotVO.startTime ?? "",
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              timeslotVO.cinemaDayTimeslotId.toString() ?? "",
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              timeslotVO.startTime ?? "",
              style: TextStyle(
                color: textColor,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            // timeSlotModel.seats != 0
            //     ? Text(
            //         "${timeSlotModel.seats}",
            //         style: TextStyle(
            //           color: textColor,
            //           fontSize: kTextSmall,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       )
            //     : const SizedBox(),
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
