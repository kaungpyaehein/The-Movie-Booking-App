import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';

class CastItemView extends StatelessWidget {
  final CreditVO? credit;
  const CastItemView({super.key, required this.credit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: credit?.getProfileWithUrl() ?? "",
            errorWidget: (_, __, ___) => const Icon(
              Icons.person,
              color: kPrimaryColor,
              size: kMargin50,
            ),
            width: kMargin60,
            height: kMargin60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: kMarginMedium2,
        )
      ],
    );
  }
}
