import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/main_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../data/sample_vos/citiy_list.dart';
import '../utils/strings.dart';

class PickRegionPage extends StatelessWidget {
  const PickRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        title: const Text(
          kPickRegionAppBarTitle,
          style: TextStyle(
              fontSize: kTextRegular2X,
              color: kPrimaryColor,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: const SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //search field
            SearchFieldView(),

            SizedBox(
              height: kMargin30,
            ),

            //CityTitle
            CitiesTitleView(),

            //CityList
            CityListView()
          ],
        ),
      ),
    );
  }
}

class CityListView extends StatelessWidget {
  const CityListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                  (route) => false);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kMargin60,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPickReginHorizontalPadding),
                  child: Text(
                    cityList[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: kTextRegular2X,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  color: kCitiesBarColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//city title view
class CitiesTitleView extends StatelessWidget {
  const CitiesTitleView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          kCityImage,
          height: kSearchFieldHeight,
          width: kCityImageWidth,
        ),
        Container(
          height: kMarginXLarge2,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kCitiesBarColor,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kPickReginHorizontalPadding,
                vertical: kMarginMedium2),
            child: Text(
              kCitiesLabel,
              style: TextStyle(
                color: kCitiesLabelColor,
                fontSize: kTextRegular2X,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SearchFieldView extends StatelessWidget {
  const SearchFieldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPickReginHorizontalPadding),
      child: SizedBox(
        height: kSearchFieldHeight,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: kSearchFieldHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kMarginMedium),
                  gradient: const LinearGradient(
                    end: Alignment.centerLeft,
                    begin: Alignment.centerRight,
                    colors: [
                      kPickRegionSearchFieldStartGradientColor,
                      kPickRegionSearchFieldStartGradientColor,
                      kPickRegionSearchFieldEndGradientColor,
                    ],
                  ),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: kSearchRegionHintLabel,
                    hintStyle: const TextStyle(
                      color: kSearchFieldTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Image.asset(
                      kSearchIcon,
                      height: kPickReginHorizontalPadding,
                      width: kPickReginHorizontalPadding,
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,

                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide.none,
                    //   borderRadius: BorderRadius.circular(kMarginMedium),
                    // ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide.none,
                    //   borderRadius: BorderRadius.circular(kMarginMedium),
                    // ),
                  ),
                ),
              ),
            ),
            //Spacer
            const SizedBox(
              width: kMarginMedium4,
            ),
            //location arrow button view
            Image.asset(
              kLocationArrowButton,
              height: kSearchFieldHeight,
              width: kSearchFieldHeight,
            ),
          ],
        ),
      ),
    );
  }
}
