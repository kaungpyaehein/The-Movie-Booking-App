import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/pages/booking_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../data/vos/credit_vo.dart';
import '../list_items/cast_item_view.dart';
import '../utils/images.dart';

class MovieDetailsPage extends StatefulWidget {
  final bool isComingSoonPage;

  /// will receive from previous screen
  final String? movieId;
  const MovieDetailsPage({
    super.key,
    required this.isComingSoonPage,
    required this.movieId,
  });

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  //Movie Model
  final MovieBookingModel _model = MovieBookingModel();

  // states
  MovieVO? movieDetails;
  List<CreditVO>? creditList;

  //get the state

  @override
  void initState() {
    /// Get Movie Details from Database

    _model
        .getMovieByIdFromDatabase(int.parse(widget.movieId ?? "0"))
        .then((movie) {
      // if (movie == null) {
      //   print("Null");
      // } else {
      //   print(movie.genres);
      // }
      setState(() {
        movieDetails = movie;
      });
    });

    /// Get movie details from network
    _model.getMovieDetails(widget.movieId ?? "").then((movie) {
      setState(() {
        movieDetails = movie;
      });
    });

    /// Get credit list from network
    _model.getCreditsByMovie(widget.movieId ?? "").then((credits) {
      setState(() {
        creditList = credits;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: movieDetails == null
          ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : SafeArea(
              child: Stack(
                children: [
                  ///body
                  ///to make app bar appears on top of body
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //Movie, Large Image, Small Image
                        MovieLargeImageSmallImageAndInfoView(
                          movie: movieDetails,
                        ),

                        //Spacer
                        const SizedBox(
                          height: kMargin30,
                        ),

                        //Censor Rating, Release date and duration
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium2),
                          child: CensorRatingReleaseDateAndDurationView(
                            movie: movieDetails,
                          ),
                        ),
                        //spacer
                        const SizedBox(
                          height: kMargin30,
                        ),
                        Visibility(
                            visible: widget.isComingSoonPage,
                            child: const SetNotificationView()),
                        //story line view
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium2),
                          child: StoryLineView(
                            movie: movieDetails,
                          ),
                        ),

                        //spacer
                        const SizedBox(
                          height: kMargin30,
                        ),

                        //cast view
                        Visibility(
                          visible: !(creditList?.isEmpty ?? true),
                          child: CastView(
                            creditList: creditList ?? [],
                          ),
                        ),

                        const SizedBox(
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
                  Visibility(
                    visible: !widget.isComingSoonPage,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 128,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.transparent,
                              kBackgroundColor
                            ])),
                        child: Center(
                          child: PrimaryButton(
                            label: kBookingLabel,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BookingPage(),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

//set notification view
class SetNotificationView extends StatelessWidget {
  const SetNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSetNotificationContainerHeight,
      margin: const EdgeInsets.only(
          left: kMarginMedium2, bottom: kMargin30, right: kMarginMedium2),
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginCardMedium2, vertical: kMargin18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMarginMedium2),
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            kSetNotificationGradientStartColor,
            kSetNotificationGradientMiddleColor,
            kSetNotificationGradientEndColor,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Releasing in 5 days",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: kTextRegular2X),
              ),

              Text(
                kGetNotifyText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kSetNotificationCardTextColor),
              ),

              //set notification button view
              SetNotificationButtonView()
            ],
          ),
          Image.asset(
            kSetNotificationImage,
            height: kSetNotificationImageHeight,
            width: kSetNotificationImageWidth,
          )
        ],
      ),
    );
  }
}

class SetNotificationButtonView extends StatelessWidget {
  const SetNotificationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSetNotificationButtonViewHeight,
      width: kSetNotificationButtonViewWidth,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.notifications_active,
            color: Colors.black,
          ),
          Text(
            kSetNotificationText,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: kTextRegular),
          ),
        ],
      ),
    );
  }
}

//booking button
class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  const PrimaryButton({super.key, required this.label, required this.onTap});

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
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: kBookingButtonHeight,
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
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
  final List<CreditVO> creditList;
  const CastView({
    super.key,
    required this.creditList,
  });

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
        //circle photo view
        SizedBox(
          height: kMargin60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            itemCount: creditList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CastItemView(
                credit: creditList[index],
              );
            },
          ),
        )
      ],
    );
  }
}

class StoryLineView extends StatelessWidget {
  final MovieVO? movie;
  const StoryLineView({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Story line",
          style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: kMarginMedium,
        ),
        Text(
          movie?.overview ?? "",
          style: const TextStyle(
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
  final MovieVO? movie;
  const CensorRatingReleaseDateAndDurationView(
      {super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CensorRatingReleaseDateAndDurationItemView(
          label: "Censor Rating",
          value: "U/A",
        ),
        CensorRatingReleaseDateAndDurationItemView(
          label: "Release Date",
          value: movie?.getReleaseDateFormatted() ?? "",
        ),
        CensorRatingReleaseDateAndDurationItemView(
          label: "Duration",
          value: movie?.getRunTimeFormatted() ?? "",
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
  final MovieVO? movie;
  const MovieLargeImageSmallImageAndInfoView({super.key, required this.movie});

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
                movie?.getBackdropPathWithBaseUrl() ?? "",
                height: kMovieDetailsTopImageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: kMarginMedium2,
              ),
              //movie info and genre view
              MovieInfoAndGenresView(
                movie: movie,
              ),
            ],
          ),

          //small image
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: kMarginMedium2, bottom: kMarginMedium2),
              child: Image.network(
                movie?.getPosterPathWithBaseUrl() ?? "",
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
  final MovieVO? movie;
  const MovieInfoAndGenresView({super.key, required this.movie});

  // final List<String> genreList = [
  //   "Action",
  //   "Adventure",
  //   "Drama",
  //   "Animation",
  // ];

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
            MovieNameAndRatingView(
              movie: movie,
            ),
            const SizedBox(height: kMarginMedium2),

            //text
            const Text(
              "2D, 3D, 3D IMAX, 3D DBOX",
              style: TextStyle(
                  fontSize: kTextRegular,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: kMarginMedium2),
            //genre
            Wrap(
              spacing: kMarginMedium,
              runSpacing: kMarginMedium,
              children: movie?.genres
                      ?.take(5)
                      .map((genre) => genre.name ?? "")
                      .map((name) => Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.circular(kMarginCardMedium2),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMarginMedium,
                                vertical: kMarginSmall),
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: kTextSmall,
                              ),
                            ),
                          ))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieNameAndRatingView extends StatelessWidget {
  final MovieVO? movie;
  const MovieNameAndRatingView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //movie name
        Expanded(
          child: Text(
            movie?.title ?? "",
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white,
                fontSize: kTextRegular2X,
                fontWeight: FontWeight.bold),
          ),
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
        Text(
          movie?.getRatingTwoDecimals() ?? "",
          style: const TextStyle(
              color: Colors.white,
              fontSize: kTextRegular2X,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
