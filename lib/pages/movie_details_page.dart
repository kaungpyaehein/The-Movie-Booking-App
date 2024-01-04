import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/booking_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../list_items/cast_item_view.dart';
import '../utils/images.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            ///body
            ///to make app bar appears on top of body
            const SingleChildScrollView(
              child: Column(
                children: [
                  //Movie, Large Image, Small Image
                  MovieLargeImageSmallImageAndInfoView(),

                  //Spacer
                  SizedBox(
                    height: kMargin30,
                  ),

                  //Censor Rating, Release date and duration
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                    child: CensorRatingReleaseDateAndDurationView(),
                  ),
                  //spacer
                  SizedBox(
                    height: kMargin30,
                  ),

                  //story line view
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                    child: StoryLineView(),
                  ),

                  //spacer
                  SizedBox(
                    height: kMargin30,
                  ),

                  //cast view
                  CastView(),

                  SizedBox(
                    height: 148,
                  )
                ],
              ),
            ),

            /// App bar
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMarginLarge, vertical: kMarginMedium),
              child: Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: kMarginXLarge,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: kMarginLarge,
                  ),
                ],
              ),
            ),

            //bottom section
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 128,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, kBackgroundColor])),
                child: const Center(
                  child: BookingButton(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//booking button

class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: kBookingButtonHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(kBookingButtonEnd),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BookingPage(),));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: kBookingButtonHeight,
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: const Center(
                  child: Text(
                    kBookingLabel,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(kBookingButtonEnd),
          ),
        ],
      ),
    );
  }
}

//cast view
class CastView extends StatelessWidget {
  const CastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Text(
            "Cast",
            style: TextStyle(
                color: Colors.white,
                fontSize: kTextRegular,
                fontWeight: FontWeight.w600),
          ),
        ),
        //spacer
        const SizedBox(
          height: kMarginMedium3,
        ),
        //circle photots view
        SizedBox(
          height: kMargin60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const CastItemView();
            },
          ),
        )
      ],
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Story line",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: kMarginMedium,
        ),
        Text(
          "Real love crosses paths with unspeakable betrayal as Mollie Burkhart, a member of the Osage Nation, tries to save her community from a spree of murders fueled by oil and greed.",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// censor rating release data and duration
class CensorRatingReleaseDateAndDurationView extends StatelessWidget {
  const CensorRatingReleaseDateAndDurationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CensorRatingReleaseDateAndDurationItemView(
          label: "Censor Rating",
          value: "U/A",
        ),
        CensorRatingReleaseDateAndDurationItemView(
          label: "Release Date",
          value: "May 8th,2022",
        ),
        CensorRatingReleaseDateAndDurationItemView(
          label: "Duration",
          value: "2hr 15min",
        ),
      ],
    );
  }
}

class CensorRatingReleaseDateAndDurationItemView extends StatelessWidget {
  final String label;
  final String value;
  const CensorRatingReleaseDateAndDurationItemView({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMarginMedium2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginCardMedium2),
          gradient: const LinearGradient(colors: [
            kMovieDetailsSensorRatingGradientStartColor,
            kMovieDetailsSensorRatingGradientEndColor,
          ])),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextSmall),
          ),
          const SizedBox(
            height: kMarginMedium,
          ),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: kTextRegular),
          ),
        ],
      ),
    );
  }
}

class MovieLargeImageSmallImageAndInfoView extends StatelessWidget {
  const MovieLargeImageSmallImageAndInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMovieDetailsTopSectionHeight,
      child: Stack(
        children: [
          //large image and info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //large image
              Image.network(
                "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/e2fd9882892035.5d2c3c960586e.jpg",
                height: kMovieDetailsTopImageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: kMarginMedium2,
              ),
              //movie info and genre view
              MovieInfoAndGenresView(),
            ],
          ),

          //small image
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: kMarginMedium2, bottom: kMarginMedium2),
              child: Image.network(
                "https://dbdzm869oupei.cloudfront.net/img/posters/preview/91008.png",
                width: kMovieDetailsSmallImageWidth,
                height: kMovieDetailsSmallImageHeight,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieInfoAndGenresView extends StatelessWidget {
  MovieInfoAndGenresView({super.key});

  final List<String> genreList = [
    "Action",
    "Adventure",
    "Drama",
    "Animation",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.57,
      child: Padding(
        padding: const EdgeInsets.only(left: kMarginMedium2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///movie name and rating view
            const MovieNameAndRatingView(),
            const SizedBox(height: kMarginMedium2),

            //text
            const Text(
              "2D, 3D, 3D IMAX, 3D DBOX",
              style: TextStyle(
                  fontSize: kTextRegular2X,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: kMarginMedium2),
            //genre
            Wrap(
                spacing: kMarginMedium,
                runSpacing: kMarginMedium,
                children: genreList
                    .map((genre) => Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius:
                                BorderRadius.circular(kMarginCardMedium2),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium,
                              vertical: kMarginSmall),
                          child: Text(
                            genre,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: kTextSmall,
                            ),
                          ),
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

class MovieNameAndRatingView extends StatelessWidget {
  const MovieNameAndRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //movie name
        const Text(
          "Stranger Things",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular2X,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: kMarginMedium,
        ),
        Image.asset(
          kIMDBImage,
          width: kIMDBWidth,
          height: kIMDBHeight,
        ),
        //rating
        const Text(
          "7.1",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular2X,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
