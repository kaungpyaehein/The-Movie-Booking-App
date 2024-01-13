import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';

import '../data/sample_data.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // profile top section
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    kProfileBackgroundImage,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                          kProfileIcon,
                          height: kDateListHeight,
                          width: kDateListHeight,
                        ),
                        const SizedBox(
                          height: kMarginMedium4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginXLarge2,
                              vertical: kMarginMedium2),
                          decoration: BoxDecoration(
                              color: kLoginOrSignupButtonBackgroundColor,
                              borderRadius:
                                  BorderRadius.circular(kMarginMedium),
                              border: Border.all(color: kPrimaryColor)),
                          child: const Text(
                            "Login or Sign UP",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: kTextRegular2X,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //profile bottom section
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: kMarginLarge,
                      right: kMarginLarge,
                      bottom: kMarginXXLarge3),
                  itemCount: profileItemDateList.length,
                  itemBuilder: (context, index) {
                    return ProfileItemView(
                      label: profileItemDateList[index].label,
                      iconData: profileItemDateList[index].iconData,
                      isLastItem: index != profileItemDateList.length - 1,
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

//profile item tile view
class ProfileItemView extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool isLastItem;
  const ProfileItemView(
      {super.key,
      required this.iconData,
      required this.label,
      required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: kMarginMedium4,
        ),
        Row(
          children: [
            //icon
            Icon(
              iconData,
              size: kLocationIconSize,
              color: Colors.white,
            ),

            //spacer
            const SizedBox(
              width: kMarginMedium2,
            ),

            //label
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: kText18),
            ),

            //Spacer
            const Spacer(),

            //icon

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: kDividerColor,
            ),
          ],
        ),
        const SizedBox(
          height: kMarginMedium4,
        ),
        Visibility(
          visible: isLastItem,
          child: Divider(
            thickness: 1,
            color: kTimeSlotCardUnavailableBackgroundColor,
          ),
        )
      ],
    );
  }
}
