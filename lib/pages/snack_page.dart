import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/pages/checkout_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../utils/strings.dart';
import 'package:badges/badges.dart' as badges;

class SnackPage extends StatefulWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final String cinemaName;

  const SnackPage(
      {super.key,
      required this.selectedSeatList,
      required this.totalSeatPrice,
      required this.date,
      required this.timeslotVO,
      required this.cinemaName});

  @override
  State<SnackPage> createState() => _SnackPageState();
}

class _SnackPageState extends State<SnackPage> {
  List<SnackCategoryVO> snackCategories = [];
  List<SnackVO> snackVos = [];
  bool isShowing = false;
  int index = 0;
  final MovieBookingModel model = MovieBookingModel();

  @override
  void initState() {
    model.getSnacksByCategoryId(0).then((snacks) {
      setState(() {
        snackVos = snacks;
        snackCategories.add(SnackCategoryVO(
          title: "All",
          id: 0,
          isSelected: false,
          createdAt: "",
          deletedAt: "",
          isActive: 1,
          titleMm: "All",
          updatedAt: "",
        ));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          kSnackPageAppBarTitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: kAppBarTitleFontSize,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: kMarginXLarge,
                color: Colors.white,
              )),
          const SizedBox(
            width: kMarginMedium2,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      selectedSeatList: widget.selectedSeatList,
                      totalSeatPrice: widget.totalSeatPrice,
                      date: widget.date,
                      timeslotVO: widget.timeslotVO,
                      snackList: const [],
                      cinemaName: widget.cinemaName,
                    ),
                  ));
            },
            child: const Text(kSkipLabel,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: kTextRegular3X,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(
            width: kMarginMedium4,
          )
        ],
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: snackVos.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  DefaultTabController(
                    length: snackCategories.length,
                    child: Column(
                      children: [
                        Container(
                          height: kMargin60,
                          margin: const EdgeInsets.only(left: kMarginMedium2),
                          child: TabBar(
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: kTextRegular2X,
                                  fontWeight: FontWeight.w600),
                              unselectedLabelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: kTextRegular2X,
                                  fontWeight: FontWeight.w600),
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: kMarginCardMedium2),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: kPrimaryColor,
                              indicatorWeight: kMarginSmall,
                              dividerColor: Colors.transparent,
                              automaticIndicatorColorAdjustment: true,
                              isScrollable: true,
                              tabAlignment: TabAlignment.center,
                              tabs: snackCategories
                                  .map(
                                    (category) => Tab(
                                      text: category.title,
                                    ),
                                  )
                                  .toList()),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: snackCategories.map((category) {
                              return SnackItemsGridView(
                                addSnack: (snackVO) {
                                  setState(() {
                                    snackVos = snackVos.map((snack) {
                                      if (snack.id == snackVO.id) {
                                        return snack.copyWith(
                                            quantity: snack.quantity + 1);
                                      } else {
                                        return snack;
                                      }
                                    }).toList();
                                  });
                                },
                                removeSnack: (snackVO) {
                                  setState(() {
                                    snackVos = snackVos.map((snack) {
                                      if (snack.id == snackVO.id &&
                                          snack.quantity > 0) {
                                        return snack.copyWith(
                                            quantity: snack.quantity - 1);
                                      } else {
                                        return snack;
                                      }
                                    }).toList();
                                  });
                                },
                                snackList: snackVos,
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  //snack bottom button view
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SnackBottomView(
                      onTapExpand: () {
                        setState(() {
                          isShowing = !isShowing;
                        });
                      },
                      onTapBottomView: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                selectedSeatList: widget.selectedSeatList,
                                totalSeatPrice: widget.totalSeatPrice,
                                date: widget.date,
                                timeslotVO: widget.timeslotVO,
                                snackList: snackVos,
                                cinemaName: widget.cinemaName,
                              ),
                            ));
                      },
                      isShow: isShowing,
                      snackList: snackVos,
                      add: (snackVO) {
                        setState(() {
                          snackVos = snackVos.map((snack) {
                            if (snack.id == snackVO.id) {
                              return snack.copyWith(
                                  quantity: snack.quantity + 1);
                            } else {
                              return snack;
                            }
                          }).toList();
                        });
                      },
                      remove: (snackVO) {
                        setState(() {
                          snackVos = snackVos.map((snack) {
                            if (snack.id == snackVO.id && snack.quantity > 0) {
                              return snack.copyWith(
                                  quantity: snack.quantity - 1);
                            } else {
                              return snack;
                            }
                          }).toList();
                        });
                      },
                      //remove item
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

//snack bottom view
class SnackBottomView extends StatefulWidget {
  final void Function() onTapExpand;
  final void Function() onTapBottomView;
  final bool isShow;
  final List<SnackVO> snackList;
  final Function(SnackVO snackVO) add;
  final Function(SnackVO snackVO) remove;

  const SnackBottomView({
    super.key,
    required this.onTapExpand,
    required this.isShow,
    required this.snackList,
    required this.add,
    required this.remove,
    required this.onTapBottomView,
  });

  @override
  State<SnackBottomView> createState() => _SnackBottomViewState();
}

class _SnackBottomViewState extends State<SnackBottomView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kMarginMedium4),
            topRight: Radius.circular(kMarginMedium4),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: !widget.isShow,
            child: const SizedBox(
              height: kMarginXLarge,
            ),
          ),
          Visibility(
            visible: widget.isShow && widget.snackList.isNotEmpty,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.snackList.length,
                itemBuilder: (context, index) {
                  return AddRemoveView(
                    snackVO: widget.snackList[index],
                    add: widget.add,
                    remove: widget.remove,
                  );
                }),
          ),
          SnackBottomButtonView(
            onTapExpand: widget.onTapExpand,
            isShow: widget.isShow,
            snackList: widget.snackList,
            onTap: widget.onTapBottomView,
          ),
          const SizedBox(
            height: kMargin30,
          )
        ],
      ),
    );
  }
}

// snack bottom button
class SnackBottomButtonView extends StatelessWidget {
  final void Function() onTapExpand;
  final void Function() onTap;
  final bool isShow;
  final List<SnackVO> snackList;
  const SnackBottomButtonView(
      {super.key,
      required this.onTapExpand,
      required this.isShow,
      required this.snackList,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kMarginLarge),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(kMarginMedium2)),
        height: kSearchFieldHeight,
        child: Row(
          children: [
            const SizedBox(
              width: kMarginMedium4,
            ),
            badges.Badge(
              position: badges.BadgePosition.topEnd(),
              badgeContent: Text(
                snackList
                    .where((snack) => snack.quantity != 0)
                    .length
                    .toString(),
                style:
                    const TextStyle(color: Colors.white, fontSize: kTextSmall),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
              child: Image.asset(
                kSnackIcon,
                height: kMarginLarge,
                width: kMarginLarge,
              ),
            ),
            const SizedBox(
              width: kMarginSmall,
            ),
            IconButton(
                onPressed: onTapExpand,
                icon: isShow
                    ? const Icon(
                        Icons.keyboard_arrow_up_outlined,
                        size: 30,
                      )
                    : const Icon(Icons.keyboard_arrow_down_sharp, size: 30)),
            const Spacer(),
            Text(
              "${getTotalSnackAmount(snackList)}Ks",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: kTextRegular2X),
            ),
            const SizedBox(
              width: kMarginMedium3,
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
            const SizedBox(
              width: kMarginMedium4,
            ),
          ],
        ),
      ),
    );
  }
}

//SnackItemsGridView
class SnackItemsGridView extends StatefulWidget {
  final List<SnackVO> snackList;
  final Function(SnackVO snackVO) addSnack;
  final Function(SnackVO snackVO) removeSnack;
  const SnackItemsGridView({
    super.key,
    required this.snackList,
    required this.addSnack,
    required this.removeSnack,
  });

  @override
  State<SnackItemsGridView> createState() => _SnackItemsGridViewState();
}

class _SnackItemsGridViewState extends State<SnackItemsGridView> {
  int selectedIndex = 0;
  int itemCount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
          top: kMargin30,
          left: kSnackPageGridViewSpacing,
          right: kSnackPageGridViewSpacing,
          bottom: kSnackItemImageWidth),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: kSnackPageGridViewSpacing,
          mainAxisSpacing: kSnackPageGridViewSpacing,
          mainAxisExtent: kSnackItemHeight),
      itemCount: widget.snackList.length,
      itemBuilder: (context, index) {
        SnackVO snack = widget.snackList[index];
        //grid view
        return SnackItemView(
          add: widget.addSnack,
          remove: widget.removeSnack,
          snackVO: snack,
        );
      },
    );
  }
}

//SnackItemView
class SnackItemView extends StatelessWidget {
  final SnackVO snackVO;
  final Function(SnackVO snackVO) remove;
  final Function(SnackVO snackVO) add;

  const SnackItemView({
    super.key,
    required this.snackVO,
    required this.remove,
    required this.add,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(snackVO.quantity.toString());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kSnackItemCardGradientStartColor,
                kSnackItemCardGradientEndColor,
              ]),
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kMargin5,
          ),
          //snack image
          Center(
            child: Image.network(
              snackVO.image ?? "",
              fit: BoxFit.cover,
              height: kSnackItemImageHeight,
              width: kSnackItemImageWidth,
            ),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),
          //name
          Text(
            snackVO.name ?? "",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: kTextSmall),
          ),
          const SizedBox(
            height: kMargin5,
          ),

          //price
          Text(
            "${snackVO.price}Ks",
            style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: kTextSmall),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),

          //add button
          snackVO.quantity == 0
              ? AddButton(
                  onTap: () {
                    add(snackVO);
                  },
                )
              : AddOrRemoveButton(
                  itemCount: snackVO.quantity,
                  add: () {
                    add(snackVO);
                  },
                  remove: () {
                    remove(snackVO);
                  },
                ),
        ],
      ),
    );
  }
}

//add or remove button

class AddOrRemoveButton extends StatelessWidget {
  final void Function() add;
  final void Function() remove;
  final int itemCount;
  const AddOrRemoveButton(
      {super.key,
      required this.itemCount,
      required this.add,
      required this.remove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMargin30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(kMarginSmall),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //remove item
            GestureDetector(
              onTap: remove,
              child: Container(
                height: kMarginLarge,
                decoration: BoxDecoration(
                    boxShadow: [addRemoveBoxShadow],
                    color: kPrimaryColor,
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.remove,
                  color: kNowPlayingAndComingSoonUnSelectedTextColor,
                  size: kMarginMedium4,
                ),
              ),
            ),
            //spacer
            const SizedBox(
              width: kMarginMedium2,
            ),

            //item count
            Text(
              itemCount.toString(),
              style: const TextStyle(
                  color: kPrimaryColor, fontWeight: FontWeight.w600),
            ),
            //spacer
            const SizedBox(
              width: kMarginMedium2,
            ),

            //add item
            GestureDetector(
              onTap: add,
              child: Container(
                height: kMarginLarge,
                decoration: BoxDecoration(
                    boxShadow: [addRemoveBoxShadow],
                    color: kPrimaryColor,
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  color: kNowPlayingAndComingSoonUnSelectedTextColor,
                  size: kMarginMedium4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//add remove view
class AddRemoveView extends StatelessWidget {
  final SnackVO snackVO;
  final Function(SnackVO snackVO) add;
  final Function(SnackVO snackVO) remove;
  const AddRemoveView({
    super.key,
    required this.snackVO,
    required this.add,
    required this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: snackVO.quantity > 0,
      child: Container(
        width: double.infinity,
        height: kMargin30,
        margin: const EdgeInsets.symmetric(
            horizontal: kMarginLarge, vertical: kMarginMedium4),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(kMarginSmall),
        ),
        child: Row(
          children: [
            //item name
            Expanded(
              child: Text(
                snackVO.name ?? "",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            AddOrRemoveButton(
              itemCount: snackVO.quantity,
              add: () {
                add(snackVO);
              },
              remove: () {
                remove(snackVO);
              },
            ),

            const Spacer(),
            // //add remove
            // Container(
            //   decoration: const BoxDecoration(
            //       color: kPrimaryColor, shape: BoxShape.circle),
            //   child: const Icon(
            //     Icons.remove,
            //     color: kSnackItemAddRemoveButtonColor,
            //     size: kMarginLarge,
            //   ),
            // ),
            // const SizedBox(
            //   width: kMarginCardMedium2,
            // ),
            // const Text(
            //   "1",
            //   style: TextStyle(
            //       color: kPrimaryColor,
            //       fontWeight: FontWeight.w700,
            //       fontSize: kTextRegular2X),
            // ),
            // const SizedBox(
            //   width: kMarginCardMedium2,
            // ),
            // Container(
            //   decoration: const BoxDecoration(
            //       color: kPrimaryColor, shape: BoxShape.circle),
            //   child: const Icon(
            //     Icons.add,
            //     color: kSnackItemAddRemoveButtonColor,
            //     size: kMarginLarge,
            //   ),
            // ),
            // const SizedBox(
            //   width: kMarginXXLarge3,
            // ),

            //item price
            Text(
              "${snackVO.price! * snackVO.quantity}Ks",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: kTextRegular,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

//add button
class AddButton extends StatelessWidget {
  final void Function() onTap;
  const AddButton({
    super.key,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: kMargin30,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kMarginSmall),
        ),
        child: const Center(
          child: Text(
            kAddLabel,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

String getTotalSnackAmount(List<SnackVO> snackList) {
  return snackList
      .map((snack) => snack.price! * snack.quantity)
      .fold(0, (prev, price) => prev + price)
      .toString();
}


