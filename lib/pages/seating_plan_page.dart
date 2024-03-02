import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/seat_vos.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/snack_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../data/vos/seat_vo.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class SeatingPlanPage extends StatefulWidget {
  final String date;
  final TimeslotVO timeslotVO;
  const SeatingPlanPage(
      {super.key, required this.date, required this.timeslotVO});

  @override
  State<SeatingPlanPage> createState() => _SeatingPlanPageState();
}

class _SeatingPlanPageState extends State<SeatingPlanPage> {
  TransformationController transformationController =
      TransformationController();
  double _zoomLevel = .5;
  List<SeatVO> seatVOList = [
    SeatVO(
      id: 1,
      price: 0,
      seatName: "A",
      type: "text",
    ),
    SeatVO(
      id: 2,
      price: 0,
      seatName: "",
      type: "available",
    ),
    SeatVO(
      id: 3,
      price: 2,
      seatName: "A-1",
      type: "available",
    ),
    SeatVO(
      id: 4,
      price: 2,
      seatName: "A-4",
      type: "taken",
    ),
    SeatVO(
      id: 5,
      price: 2,
      seatName: "A-5",
      type: "available",
    ),
    SeatVO(
      id: 6,
      price: 2,
      seatName: "A-6",
      type: "space",
    ),
    SeatVO(
      id: 7,
      price: 2,
      seatName: "A-7",
      type: "space",
    ),
    SeatVO(
      id: 8,
      price: 2,
      seatName: "A-9",
      type: "available",
    ),
    SeatVO(
      id: 9,
      price: 2,
      seatName: "A-9",
      type: "available",
    ),
    SeatVO(
      id: 10,
      price: 2,
      seatName: "A-10",
      type: "available",
    ),
    SeatVO(
      id: 11,
      price: 2,
      seatName: "",
      type: "taken",
    ),
    SeatVO(
      id: 12,
      price: 0,
      seatName: "B",
      type: "text",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kMarginXLarge,
                ),
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
                          kScreenLabel,
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
                //title text
                const Text(
                  kNormalTextLabel,
                  style: TextStyle(
                      color: kBottomNavigationUnselectedColor,
                      fontSize: kFilmTypeTextSize),
                ),

                //zoomable seats view
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _zoomLevel = .5;
                      transformationController.value = Matrix4.identity();
                    });
                  },
                  child: ZoomableSeatsView(
                    transformController: transformationController,
                    scale: _zoomLevel * 2,
                    seatVOList: seatVOList,
                    onTapSeat: (selectedSeat) {
                      setState(() {
                        seatVOList = seatVOList
                            .map((seatVO) => SeatVO(
                                id: seatVO.id,
                                price: seatVO.price,
                                seatName: seatVO.seatName,
                                type: seatVO.id == selectedSeat.id
                                    ? "selected"
                                    : seatVO.type))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),

            /// zoom slider
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //seats availability view
                    const SeatsAvailabilityView(),
                    const SizedBox(
                      height: kMarginMedium2,
                    ),
                    //seat zoom in out view
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: kNowPlayingAndComingSoonSelectedTextColor,
                          ),
                          onPressed: () {
                            setState(() {
                              //zoom out
                              if (_zoomLevel > 0.1) {
                                print(_zoomLevel);
                                _zoomLevel -= 0.1;
                                transformationController.value =
                                    Matrix4.identity()
                                      ..translate(kSeatsViewHeight / 2,
                                          kSeatsViewHeight / 2)
                                      ..scale(_zoomLevel * 2)
                                      ..translate(-kSeatsViewHeight / 2,
                                          -kSeatsViewHeight / 2);
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Slider(
                            activeColor: kBottomNavigationUnselectedColor,
                            overlayColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.white),
                            inactiveColor: kBottomNavigationUnselectedColor,
                            thumbColor: Colors.white,
                            value: _zoomLevel,
                            onChanged: (value) {
                              setState(() {
                                _zoomLevel = value;
                                transformationController.value =
                                    Matrix4.identity()
                                      ..translate(kSeatsViewHeight / 2,
                                          kSeatsViewHeight / 2)
                                      ..scale(_zoomLevel * 2)
                                      ..translate(-kSeatsViewHeight / 2,
                                          -kSeatsViewHeight / 2);
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: kNowPlayingAndComingSoonSelectedTextColor,
                          ),
                          onPressed: () {
                            setState(() {
                              //zoom in
                              _zoomLevel += 0.1;
                              transformationController
                                  .value = Matrix4.identity()
                                ..translate(
                                    kSeatsViewHeight / 2, kSeatsViewHeight / 2)
                                ..scale(_zoomLevel * 2)
                                ..translate(-kSeatsViewHeight / 2,
                                    -kSeatsViewHeight / 2);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kMarginMedium2,
                    ),
                    const BuyTicketView(),
                  ],
                )),

            // back button
            Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))
          ],
        ),
      ),
    );
  }
}

//buy ticket view
class BuyTicketView extends StatelessWidget {
  const BuyTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kMarginXXLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2 Tickets",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: kText18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "170000ks",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kTextRegular3X,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          PrimaryButton(
              label: kBuyTicketLabel,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SnackPage(),
                    ));
              })
        ],
      ),
    );
  }
}

// GestureDetector(
//   onScaleStart: (ScaleStartDetails details) {
//     print(details);
//     _previousScale = _scale;
//     setState(() {});
//   },
//   onScaleUpdate: (ScaleUpdateDetails details) {
//     print(details);
//     if (_scale < 1) {
//       _scale = 1;
//     } else {
//       _scale = _previousScale * details.scale;
//     }
//     setState(() {});
//   },
//   onScaleEnd: (ScaleEndDetails details) {
//     print(details);
//
//     _previousScale = 1.0;
//     setState(() {});
//   },
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Transform(
//         alignment: FractionalOffset.center,
//         transform:
//             Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
//         child: const SeatsView()),
//   ),
// ),

//seats zoom in out view

// Expanded(
//
//
//   child: InteractiveViewer(
//     alignment: Alignment.center,
//      trackpadScrollCausesScale: true,
//     maxScale: 2,
//     minScale: 1,
//     onInteractionStart: (ScaleStartDetails details) {
//       print(details);
//       _previousScale = _scale;
//       setState(() {});
//     },
//     onInteractionUpdate: (ScaleUpdateDetails details) {
//       print(details);
//       _scale = _previousScale * details.scale;
//       setState(() {});
//     },
//     onInteractionEnd: (ScaleEndDetails details) {
//       print(details);
//
//       _previousScale = 1.0;
//       setState(() {});
//     },
//     transformationController: transformationController,
//     child: SeatsView(),
//   ),
// )

// InteractiveViewer(
//   alignment: Alignment.center,
//   maxScale: 5,
//   minScale: 1,
//   transformationController: transformationController,
//   child: SeatsView(),
// )
//seats availability view
class SeatsAvailabilityView extends StatelessWidget {
  const SeatsAvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAvailabilityContainerHeight,
      color: kAvailabilityContainerBackgroundColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SeatsAvailabilityItemView(
            color: Colors.white,
            label: kAvailableLabel,
          ),
          SeatsAvailabilityItemView(
            color: kDividerColor,
            label: kTakenLabel,
          ),
          SeatsAvailabilityItemView(
            color: kPrimaryColor,
            label: kYourSelectionLabel,
          ),
        ],
      ),
    );
  }
}

//SeatsAvailabilityItemView
class SeatsAvailabilityItemView extends StatelessWidget {
  final Color color;
  final String label;
  const SeatsAvailabilityItemView(
      {super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: kMarginMedium2,
            width: kMarginMedium2,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: color != Colors.white
                    ? const Border.fromBorderSide(BorderSide(
                        color: kNowPlayingAndComingSoonSelectedTextColor,
                        width: 1))
                    : null),
          ),
          const SizedBox(
            width: kMarginMedium2,
          ),
          Text(
            label,
            style: const TextStyle(
                color: kNowPlayingAndComingSoonSelectedTextColor,
                fontWeight: FontWeight.w500,
                fontSize: kTextRegular2X),
          )
        ],
      ),
    );
  }
}

//seats view zoom in out
class ZoomableSeatsView extends StatefulWidget {
  final TransformationController transformController;
  final double scale;
  final List<SeatVO> seatVOList;
  final Function(SeatVO seatVO) onTapSeat;
  const ZoomableSeatsView(
      {super.key,
      required this.scale,
      required this.transformController,
      required this.seatVOList,
      required this.onTapSeat});

  @override
  State<ZoomableSeatsView> createState() => _ZoomableSeatsViewState();
}

class _ZoomableSeatsViewState extends State<ZoomableSeatsView> {
  // double _previousScale = 1;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      clipBehavior: Clip.none,
      boundaryMargin: EdgeInsets.zero,
      transformationController: widget.transformController,
      minScale: kMinScale,
      maxScale: kMaxScale,
      child: Padding(
        padding: const EdgeInsets.all(kMarginMedium),
        child: Transform(
            alignment: FractionalOffset.center,
            transform:
                Matrix4.diagonal3(Vector3(kMinScale, kMinScale, kMinScale)),
            child: SizedBox(
              height: kSeatsViewHeight,
              child: GridView.custom(
                physics: widget.scale <= 1.0
                    ? const NeverScrollableScrollPhysics()
                    : null,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: kMargin60,
                    crossAxisCount: kSeatsCount,
                    mainAxisSpacing: kMarginMedium4),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: widget.seatVOList.length,
                  (context, index) {
                    final SeatVO seatVO = widget.seatVOList[index];
                    return SeatView(
                      seatVO: seatVO,
                      onTapSeat: () {
                        widget.onTapSeat(
                            seatVO); // Invoke the onTapSeat callback with the selected seat
                      },
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}

class SeatView extends StatelessWidget {
  final SeatVO seatVO;
  final void Function() onTapSeat;
  const SeatView({super.key, required this.seatVO, required this.onTapSeat});

  @override
  Widget build(BuildContext context) {
    switch (seatVO.type) {
      case "text":
        return Center(
          child: Text(
            seatVO.seatName ?? "",
            style: const TextStyle(color: kDividerColor, fontSize: kTextSmall),
            textAlign: TextAlign.center,
          ),
        );
      case "taken":
        // return SvgPicture.asset(kTakenSeatImage);
        return const Icon(
          Icons.chair,
          size: 30,
          color: kDividerColor,
        );
      case "available":
        return GestureDetector(
          onTap: onTapSeat,
          child: const Icon(
            Icons.chair,
            size: 30,
            color: Colors.white,
          ),
        );
      case "selected":
        return const Icon(
          Icons.chair,
          size: 30,
          color: kPrimaryColor,
        );
      case "space":
        return const SizedBox(
          width: 10,
        );
      default:
        return const SizedBox();
    }
  }
}

// // seats view
// class SeatsView extends StatefulWidget {
//   final List<SeatVO> seatVOList;
//   final double scale;
//   final Function(SeatVO seatVO) onTapSeat;
//   const SeatsView(
//       {super.key,
//       required this.scale,
//       required this.seatVOList,
//       required this.onTapSeat});
//
//   @override
//   State<SeatsView> createState() => _SeatsViewState();
// }
//
// class _SeatsViewState extends State<SeatsView> {
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

void selectSeat({required int index}) {
  seatList1[index].type = "selected";
}

void unSelectSeat({required int index}) {
  seatList1[index].type = "available";
}
