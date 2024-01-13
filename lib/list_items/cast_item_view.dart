import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';

class CastItemView extends StatelessWidget {
  const CastItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcREbZoK2xRmKYWsQlTGXxzz7tKr3wn2CUnhmkS97QidGIOHP4V9",
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
