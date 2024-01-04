import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class SeatingPlanPage extends StatelessWidget {
  const SeatingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransformationController transformationController =
        TransformationController();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: kMarginXLarge,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                kScreenImage,
                fit: BoxFit.cover,
              ),
              const Align(
                child: Padding(
                  padding: EdgeInsets.only(top: kMarginLarge),
                  child: Text(
                    "SCREEN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kTextRegular2X,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          InteractiveViewer(
            alignment: Alignment.center,
            maxScale: 5,
            minScale: 1,
            transformationController: transformationController,
            child: Image.network("https://picsum.photos/1000"),
          )
        ],
      ),
    );
  }
}
