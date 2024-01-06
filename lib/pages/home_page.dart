import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_movie_booking_app/list_items/movie_list_item_view.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kBackgroundColor,
        foregroundColor: kWhiteColor,
        title: const Row(
          children: [
            SizedBox(
              width: kMarginMedium2,
            ),
            Icon(
              Icons.location_on_outlined,
              size: kMarginLarge,
            ),
            SizedBox(
              width: kMarginMedium,
            ),
            Text(
              "Yangon",
              style: TextStyle(
                  fontSize: kTextRegular2X,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
            size: kMarginLarge,
          ),
          SizedBox(
            width: kMarginXLarge,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
            size: kMarginLarge,
          ),
          SizedBox(
            width: kMarginXLarge,
          ),
          Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: kMarginLarge,
          ),
          SizedBox(
            width: kHomeScreenAppBarRightMargin,
          ),
        ],
      ),
      body: const HomeScreenBodyView(),
    );
  }
}

//home screen body view
class HomeScreenBodyView extends StatefulWidget {
  const HomeScreenBodyView({super.key});

  @override
  State<HomeScreenBodyView> createState() => _HomeScreenBodyViewState();
}

class _HomeScreenBodyViewState extends State<HomeScreenBodyView> {
  String selectedText = kNowShowingLabel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //Banner
        SliverToBoxAdapter(
          child: BannerSectionView(),
        ),

        ///Spacer
        const SliverToBoxAdapter(
          child: SizedBox(
            height: kMargin30,
          ),
        ),

        ///Now Playing and Coming Soon Tab Bar
        SliverToBoxAdapter(
            child: NowShowingAndComingSoonTabBar(
          selectedText: selectedText,
          onTapNowShowingOrComingSoon: (text) {
            setState(() {
              selectedText = text;
            });
          },
        )),

        ///Spacer
        const SliverToBoxAdapter(
          child: SizedBox(
            height: kMargin30,
          ),
        ),

        /// movie list grid view
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMarginLarge,
          ),
          sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              isComingSoonPage:
                                  selectedText == kComingSoonLabel,
                            ),
                          ));
                    },
                    child: MovieListItemView(
                        isComingSoonSelected: selectedText == kComingSoonLabel),
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: kMovieListItemHeight,
                mainAxisSpacing: kMarginMedium4,
                crossAxisSpacing: kMarginMedium4,
              )),
        )
      ],
    );
  }
}

//banner
class BannerSectionView extends StatelessWidget {
  BannerSectionView({super.key});
  final PageController _bannerPageController =
      PageController(viewportFraction: 0.9, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Page View
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _bannerPageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: kMarginMedium),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kMarginMedium),
                  child: Image.asset(
                    kBannerImage,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        // Spacer
        const SizedBox(
          height: kMarginMedium2,
        ),

        /// Dots indicator
        SmoothPageIndicator(
          controller: _bannerPageController,
          count: 5,
          effect: const SlideEffect(
              dotColor: kDotsInactiveColor,
              activeDotColor: kPrimaryColor,
              dotHeight: kMarginMedium,
              dotWidth: kMarginMedium),
          onDotClicked: (index) {
            // _bannerPageController.jumpToPage(index);
            _bannerPageController.animateToPage(index,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeOut);
          },
        ),
      ],
    );
  }
}

///now showing and coming soon tab bar
class NowShowingAndComingSoonTabBar extends StatelessWidget {
  final String selectedText;
  final Function(String) onTapNowShowingOrComingSoon;
  const NowShowingAndComingSoonTabBar(
      {super.key,
      required this.selectedText,
      required this.onTapNowShowingOrComingSoon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: nowPlayingAndComingSoonTabBarHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: kMarginLarge,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin5),
          gradient: const RadialGradient(
            colors: [
              knowPlayingAndComingSoonGradientStartColor,
              knowPlayingAndComingSoonGradientEngColor
            ],
            radius: 7.5,
            center: Alignment(0, -0.02),
          )),
      child: Row(
        children: [
          Expanded(
              child: NowShowingOrComingSoonButtonView(
            onTapButton: () {
              onTapNowShowingOrComingSoon(kNowShowingLabel);
            },
            isSelected: selectedText == kNowShowingLabel,
            label: kNowShowingLabel,
          )),
          Expanded(
              child: NowShowingOrComingSoonButtonView(
                  onTapButton: () {
                    onTapNowShowingOrComingSoon(kComingSoonLabel);
                  },
                  isSelected: selectedText == kComingSoonLabel,
                  label: kComingSoonLabel)),
        ],
      ),
    );
  }
}

class NowShowingOrComingSoonButtonView extends StatelessWidget {
  final bool isSelected;
  final String label;
  final Function onTapButton;

  const NowShowingOrComingSoonButtonView(
      {super.key,
      required this.isSelected,
      required this.label,
      required this.onTapButton});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapButton();
      },
      child: Container(
        margin: const EdgeInsets.all(kMarginMedium),
        decoration: BoxDecoration(
            color: (isSelected) ? kPrimaryColor : null,
            borderRadius: BorderRadius.circular(kMarginSmall)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: (isSelected)
                    ? kNowPlayingAndComingSoonSelectedTextColor
                    : kNowPlayingAndComingSoonUnSelectedTextColor,
                fontSize: kTextRegular2X,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
