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

  List<CinemaVO> cinemaVOs = [];
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isSelected = false;
  bool isLoading = true;

  @override
  void initState() {
    /// GET Two weeks dates
    twoWeekDates = model.getTwoWeeksOfDates().map((dates) {
      return ChooseDateVO(dates.date, dates.date == selectedDate);
    }).toList();
    // Get timeslot data
    getCinemaData(selectedDate);

    super.initState();
  }

  void getCinemaData(String date) {
    model.getCinemasAndShowTimeByDate(date).then((cinemas) {
      setState(() {
        isLoading = false;
        cinemaVOs = cinemas;
        debugPrint(cinemas[0].timeslots![0].status.toString());
      });
    });
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: CustomScrollView(
              slivers: [
                //Date List View
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: kDateListHeight,
                    child: ListView.builder(
                      key: const PageStorageKey(0),
                      itemCount: twoWeekDates.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final ChooseDateVO chooseDateVO = twoWeekDates[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: DateCardView(
                            chooseDateVO: chooseDateVO,
                            onTap: () {
                              isLoading = true;
                              setState(() {
                                twoWeekDates = twoWeekDates.map((dateTime) {
                                  return ChooseDateVO(dateTime.date,
                                      dateTime.date == chooseDateVO.date);
                                }).toList();
                                selectedDate = chooseDateVO.date;

                                /// Change Cinema Data According to The Date
                                getCinemaData(chooseDateVO.date);

                                // model.getCinemasAndShowTimeByDate();
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
                    padding: EdgeInsets.symmetric(
                        horizontal: kPickReginHorizontalPadding),
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

                /// Cinema View
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: cinemaVOs.length, (context, index) {
                  final cinemaVO = cinemaVOs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: kMarginSmall),
                    child: CinemasView(
                      isShow: true,
                      cinemaVO: cinemaVO,
                      onTapTimeslot: (timeslotVO) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatingPlanPage(
                                timeslotVO: timeslotVO,
                                date: selectedDate,
                                cinemaName: cinemaVO.cinema ?? "",

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
  final ChooseDateVO chooseDateVO;
  final void Function() onTap;
  const DateCardView(
      {super.key, required this.onTap, required this.chooseDateVO});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            chooseDateVO.isSelected ? kSelectedDateCard : kUnselectedDateCard,
            width: kDateCardWidth,
            height: kDateCardHeight,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(
                  height: kMarginMedium4,
                ),
                TextInsideDateCard(
                  text: chooseDateVO.getRelativeDay(),
                ),
                const SizedBox(
                  height: kMarginMedium,
                ),
                TextInsideDateCard(
                  text: chooseDateVO.getMonthName(),
                ),
                const SizedBox(
                  height: kMarginSmall,
                ),
                TextInsideDateCard(
                  text: chooseDateVO.getDayOfMonth(),
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
