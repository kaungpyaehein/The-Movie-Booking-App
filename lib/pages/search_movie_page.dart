import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';

import '../list_items/movie_list_item_view.dart';
import '../utils/dimensions.dart';
import '../utils/strings.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  bool isComingSoon = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: kBackgroundColor,
        foregroundColor: kWhiteColor,
        title: const TextField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: kSearchTheMovieText,
            hintStyle:
                TextStyle(color: kDividerColor, fontWeight: FontWeight.w400),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
            ),
            prefixIconColor: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isComingSoon = !isComingSoon;
              });
            },
            child: const Icon(
              Icons.filter_alt_rounded,
              color: kPrimaryColor,
              size: kMarginXLarge,
            ),
          ),
          const SizedBox(
            width: kMarginLarge,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kAppBarTitleFontSize),
        child: CustomScrollView(
          slivers: [
            //spacer
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kMarginMedium2,
              ),
            ),
            // filter dropdown view
            SliverToBoxAdapter(
              child: Row(
                children: [
                  const FilterDropdownView(
                    label: "Genres",
                  ),
                  const SizedBox(
                    width: kMarginMedium3,
                  ),
                  const FilterDropdownView(
                    label: "Format",
                  ),
                  const SizedBox(
                    width: kMarginMedium3,
                  ),
                  Visibility(
                    visible: isComingSoon,
                    child: const FilterDropdownView(
                      label: "Month",
                    ),
                  )
                ],
              ),
            ),
            //spacer
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kMargin30,
              ),
            ),
            //search suggestions
            SearchSuggestionsView(
              isComingSoon: isComingSoon,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchSuggestionsView extends StatelessWidget {
  final bool isComingSoon;
  const SearchSuggestionsView({
    super.key,
    required this.isComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: 8,
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(
                        isComingSoonPage: isComingSoon,
                      ),
                    ));
              },
              child: MovieListItemView(isComingSoonSelected: isComingSoon),
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: kMovieListItemHeight,
          mainAxisSpacing: kMarginMedium4,
          crossAxisSpacing: kMarginMedium4,
        ));
  }
}

class FilterDropdownView extends StatelessWidget {
  final String label;
  const FilterDropdownView({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMargin5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMarginMedium),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400),
          ),

          ///spacer

          const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
