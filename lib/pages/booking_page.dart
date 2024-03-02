import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/sample_vos/film_type_list.dart';
import 'package:the_movie_booking_app/data/vos/choose_date_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/pages/seating_plan_page.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../widgets/cinemas_view.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<ChooseDateVO> twoWeekDates = [];
  MovieBookingModel model = MovieBookingModel();

  List<CinemaVO> cinemaVOs = [
    CinemaVO(
      cinemaId: 1,
      cinema: "JCGV",
      timeslots: [
        TimeslotVO(cinemaDayTimeslotId: 2, startTime: "9:30 AM", status: 2),
        TimeslotVO(cinemaDayTimeslotId: 2, startTime: "9:30 AM", status: 3),
        TimeslotVO(cinemaDayTimeslotId: 2, startTime: "9:30 AM", status: 4),
      ],
    ),
    CinemaVO(
      cinemaId: 2,
      cinema: "MINGALAR Cinema",
      timeslots: [
        TimeslotVO(cinemaDayTimeslotId: 4, startTime: "10:00 AM", status: 2),
        TimeslotVO(cinemaDayTimeslotId: 4, startTime: "10:00 AM", status: 3),
        TimeslotVO(cinemaDayTimeslotId: 4, startTime: "10:00 AM", status: 4),
      ],
    ),
  ];

  @override
  void initState() {
    twoWeekDates = model.getTwoWeeksOfDates().map((dateTime) {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      bool isSelected =
          dateTime.date == today; // Set isSelected to true for current date
      return ChooseDateVO(dateTime.date, isSelected);
    }).toList();

    print(cinemaVOs[0].cinemaId.toString());
    super.initState();
  }

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
                itemCount: twoWeekDates.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ChooseDateVO chooseDateVO = twoWeekDates[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DateCardView(
                      month: chooseDateVO.getMonthName(),
                      isSelected: chooseDateVO.isSelected,
                      date: chooseDateVO.getRelativeDay(),
                      day: chooseDateVO.getDayOfMonth(),
                      onTap: () {
                        setState(() {
                          twoWeekDates = twoWeekDates.map((dateTime) {
                            bool isSelected = dateTime.date ==
                                chooseDateVO
                                    .date; // Set isSelected to true for current date
                            return ChooseDateVO(dateTime.date, isSelected);
                          }).toList();
                        });
                      },
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
              delegate: SliverChildBuilderDelegate(childCount: cinemaVOs.length,
                  (context, index) {
            final cinemaVO = cinemaVOs[index];
            return Padding(
              padding: EdgeInsets.only(bottom: kMarginSmall),
              child: CinemasView(
                isShow: true,
                cinemaVO: cinemaVO,
                onTapTimeslot: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatingPlanPage(
                          timeslotVO: TimeslotVO(),
                          date: "12-2-2024",
                        ),
                      ));
                },
              ),
            );
          }))
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
  final void Function() onTap;
  const DateCardView(
      {super.key,
      required this.date,
      required this.month,
      required this.day,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: isSelected
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 5,
                        offset: const Offset(5, 9),
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
      ),
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
