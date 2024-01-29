import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../data/vos/movie_vo.dart';

class MovieListItemView extends StatelessWidget {
  final bool isComingSoonSelected;
  final MovieVO movie;

  const MovieListItemView(
      {super.key, required this.isComingSoonSelected, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        children: [
          // Movie image and gradient
          Stack(
            children: [
              // Movie image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(kMarginMedium),
                    topLeft: Radius.circular(kMarginMedium)),
                child: Image.network(
                  movie.getPosterPathWithBaseUrl(),
                  height: kMovieListItemImageHeight,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              //Gradient

              Container(
                height: kMovieListItemImageHeight,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(kMarginMedium)
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                      0.0, //start form 0
                      0.6, //next start form 0.6 to black
                      1.0,
                    ],
                        colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black
                    ])),
              ),

              //indicator

              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: isComingSoonSelected,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kMarginMedium, right: kMarginMedium),
                    child: Container(
                      width: kMarginXLarge,
                      height: kMarginXLarge,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(kMarginMedium),
                      ),
                      child: const Center(
                          child: Text(
                        "8\nAUG",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kNowPlayingAndComingSoonUnSelectedTextColor,
                            fontSize: kTextXSmall),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Movie name and IMDB
          MovieNameAndIMDBView(
            movie: movie,
          ),
          //spacer
          const SizedBox(
            height: kMarginCardMedium2,
          ),

          /// additional info view
          const AdditionalInfoView()
        ],
      ),
    );
  }
}

class MovieNameAndIMDBView extends StatelessWidget {
  final MovieVO movie;
  const MovieNameAndIMDBView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
      child: Row(
        children: [
          Expanded(
            child: Text(
              movie.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: kTextSmall),
            ),
          ),
          const Spacer(),

          /// IMDB
          Image.asset(
            kIMDBImage,
            width: kMarginXLarge2,
            height: kMarginXLarge,
          ),

          /// Rating
          Text(
            movie.getRatingTwoDecimals(),
            style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

class AdditionalInfoView extends StatelessWidget {
  const AdditionalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
      child: Row(
        children: [
          ///Restriction
          const Text(
            "U/A",
            style: TextStyle(
                color: Colors.white,
                fontSize: kTextSmall,
                fontWeight: FontWeight.w600),
          ),
          //spacer
          const SizedBox(
            width: kMarginMedium,
          ),
          //Circle
          Container(
            width: kMargin5,
            height: kMargin5,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kCircleColor,
            ),
          ),
          //spacer
          const SizedBox(
            width: kMarginMedium,
          ),

          //types
          const Text(
            "2D, 3D, 3D IMAX",
            style: TextStyle(
              color: Colors.white,
              fontSize: kTextSmall,
            ),
          )
        ],
      ),
    );
  }
}
