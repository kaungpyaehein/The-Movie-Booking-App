import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/film_type_list.dart';
import 'package:the_movie_booking_app/pages/seating_plan_page.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../data/time_slot_data_list.dart';
import '../data/time_slot_model.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: kMarginXLarge,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          Image.asset(
            kLocationIcon,
            height: kLocationIconSize,
            width: kLocationIconSize,
          ),
          const Text(
            "Yangon",
            style: TextStyle(
                fontSize: kTextRegular2X,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            width: kMarginLarge,
          ),
          const Icon(
            Icons.search,
            color: Colors.white,
            size: kMarginLarge,
          ),
          const SizedBox(
            width: kMargin30,
          ),
          const Icon(
            Icons.filter_alt_sharp,
            color: Colors.white,
            size: kMarginLarge,
          ),
          const SizedBox(
            width: kMarginLarge,
          )
        ],
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          //date list view
          SliverToBoxAdapter(
            child: SizedBox(
              height: kDateListHeight,
              child: ListView.builder(
                itemCount: 14,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DateCardView(
                      month: "Jan",
                      isSelected: index.isEven,
                      date: "Today",
                      day: "1",
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: kMargin30,
            ),
          ),

          //film type view
          const SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: kPickReginHorizontalPadding),
              child: ChooseFilmTypeView(),
            ),
          ),
          //spacer
          const SliverToBoxAdapter(
            child: SizedBox(
              height: kMargin30,
            ),
          ),

          const SliverToBoxAdapter(
            child: AvailabilityView(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: kMargin30,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 3, (context, index) => const TimeView()))
        ],
      )),
    );
  }
}

//date card view
class DateCardView extends StatelessWidget {
  final String date;
  final String month;
  final String day;
  final bool isSelected;
  const DateCardView(
      {super.key,
      required this.date,
      required this.month,
      required this.day,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: isSelected
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal,
                      blurRadius: 3,
                      offset: const Offset(2, 4),
                      // changes position of shadow
                    ),
                  ],
                )
              : null,
          child: Image.asset(
            fit: BoxFit.cover,
            isSelected ? kSelectedDateCard : kUnselectedDateCard,
            width: kDateCardWidth,
            height: kDateCardHeight,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(
                height: kMarginMedium4,
              ),
              TextInsideDateCard(
                text: date,
              ),
              const SizedBox(
                height: kMarginMedium,
              ),
              TextInsideDateCard(
                text: month,
              ),
              const SizedBox(
                height: kMarginSmall,
              ),
              TextInsideDateCard(
                text: day,
              ),
            ],
          ),
        )
      ],
    );
  }
}

// text inside card view
class TextInsideDateCard extends StatelessWidget {
  final String text;
  const TextInsideDateCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black,
          fontSize: kTextRegular,
          fontWeight: FontWeight.w700),
    );
  }
}

//film type view
class ChooseFilmTypeView extends StatelessWidget {
  const ChooseFilmTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          filmTypeList.map((type) => FilmTypeButtonView(label: type)).toList(),
    );
  }
}

//film type button view
class FilmTypeButtonView extends StatelessWidget {
  final String label;
  const FilmTypeButtonView({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginCardMedium2, vertical: kMargin5),
      decoration: BoxDecoration(
          color: kNowPlayingAndComingSoonUnSelectedTextColor,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(kMargin5)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: kFilmTypeTextSize)),
    );
  }
}

//available fill full view
class AvailabilityView extends StatelessWidget {
  const AvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAvailabilityContainerHeight,
      decoration: const BoxDecoration(
        color: kAvailabilityContainerBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: kAvailabilityContainerBoxShadowColor,
            blurRadius: kMarginMedium2,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AvailabilityItemView(
            color: kAvailableColor,
            label: kAvailableLabel,
          ),
          AvailabilityItemView(
            color: kFillingFastColor,
            label: kFillingFastLabel,
          ),
          AvailabilityItemView(
            color: kAlmostFullColor,
            label: kAlmostFullLabel,
          ),
        ],
      ),
    );
  }
}

//AvailabilityItemView
class AvailabilityItemView extends StatelessWidget {
  final Color color;
  final String label;
  const AvailabilityItemView(
      {super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: kMarginMedium,
            width: kMarginMedium,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(
            width: kMarginMedium2,
          ),
          Text(
            label,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: kTextRegular2X),
          )
        ],
      ),
    );
  }
}

//time view
class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //cinema name and details
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kMarginLarge,
            ),
            const Text(
              "JCGV : Junction City",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kTextRegular2X,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              child: const Text(
                kSeeDetailsLabel,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: kTextRegular2X,
                    decorationColor: kPrimaryColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              width: kMarginLarge,
            ),
          ],
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
