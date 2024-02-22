import 'package:flutter/material.dart';

import '../data/sample_vos/sample_data.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../utils/strings.dart';

class CinemaDetailsPage extends StatelessWidget {
  const CinemaDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: const Text(
          kCinemaDetailsText,
          style: TextStyle(
              color: Colors.white,
              fontSize: kAppBarTitleFontSize,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          Image.asset(
            kStarIcon,
            height: kMarginLarge,
          ),
          const SizedBox(
            width: kMarginLarge,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //video view
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  kCinemaDetailsSampleImage,
                  height: 200,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    kPlayButton,
                    height: kMargin50,
                  ),
                )
              ],
            ),
        
            ///cinama name
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMarginLarge, vertical: kMarginMedium4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //spacer
                  const SizedBox(
                    height: kMarginLarge,
                  ),
        
                  //cinema name
                  const Text(
                    "JCGV : Junction City",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: kTextRegular2X),
                  ),
                  //spacer
                  const SizedBox(
                    height: kMarginMedium3,
                  ),
                  //location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleText(
                        title: "Q5H3+JPP, Corner of, Bogyoke\nLann, Yangon ",
                      ),
                      Image.asset(
                        kLocationIcon,
                        color: kPrimaryColor,
                        height: kMargin50,
                        width: kMargin50,
                      ),
                    ],
                  ),
        
                  //spacer
                  const SizedBox(
                    height: kMarginXLarge2,
                  ),
        
                  //facilities view
                  const FacilityView(),
        
                  const SizedBox(
                    height: kMarginLarge,
                  ),
        
                  //safety view
                  const SafetyView(),
                ],
              ),
            )
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          title: "Facilities",
        ),
        //spacer
        const SizedBox(
          height: kMarginMedium3,
        ),
        //facilities items view
        Wrap(
          children: facilityModelList.map((data) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: kMargin5, bottom: kMarginMedium3),
              child: FacilityItemView(
                label: data.label,
                image: data.icon,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

//safety view
class SafetyView extends StatelessWidget {
  const SafetyView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          title: "Safety",
        ),
        //spacer
        const SizedBox(
          height: kMarginMedium3,
        ),
        //facilities items view
        Wrap(
          children: safetyDataList.map((data) {
            return Padding(
                padding: const EdgeInsets.only(
                    right: kMargin5, bottom: kMarginMedium3),
                child: SafetyItemView(
                  label: data,
                ));
          }).toList(),
        ),
      ],
    );
  }
}

class FacilityItemView extends StatelessWidget {
  final String image;
  final String label;
  const FacilityItemView({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //icon
        Image.asset(
          image,
          height: kMarginMedium3,
          width: kMarginMedium3,
          color: kPrimaryColor,
        ),

        //spacer
        const SizedBox(
          width: kMargin5,
        ),

        //text
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: kPrimaryColor),
        ),
      ],
    );
  }
}

class SafetyItemView extends StatelessWidget {
  final String label;
  const SafetyItemView({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMarginLarge,
      padding:
          const EdgeInsets.symmetric(horizontal: kMarginMedium2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMarginSmall),
        color: kPrimaryColor,
      ),
      child: Text(
        label,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}

//title text
class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: kText18),
    );
  }
}

// text
