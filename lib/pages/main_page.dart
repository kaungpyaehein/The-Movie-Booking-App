import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/cinemas_page.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/profile_page.dart';
import 'package:the_movie_booking_app/pages/tickets_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> screenWidgets = [
    const HomePage(),
    CinemasPage(onTapTimeSlot: () {}),
    const TicketsPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kBottomNavigationUnselectedColor,
        selectedFontSize: kTextSmall,
        unselectedFontSize: kTextSmall,
        showUnselectedLabels: true,
        backgroundColor: kBackgroundColor,
        type: BottomNavigationBarType.fixed,
        onTap: (selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        items: _getBottomNavigationItems(),
      ),
      body: screenWidgets[currentIndex],
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.movie),
        activeIcon: Icon(
          Icons.movie,
          color: kPrimaryColor,
        ),
        label: kMoviesLabel,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.tv),
        activeIcon: Icon(
          Icons.tv,
          color: kPrimaryColor,
        ),
        label: kCinemaLabel,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.confirmation_num_outlined),
        activeIcon: Icon(
          Icons.confirmation_num_outlined,
          color: kPrimaryColor,
        ),
        label: kTicketLabel,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        activeIcon: Icon(
          Icons.person,
          color: kPrimaryColor,
        ),
        label: kProfileLabel,
      ),
    ];
  }
}
