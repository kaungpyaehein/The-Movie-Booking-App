import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/snack_model.dart';
import 'package:the_movie_booking_app/pages/checkout_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../data/sample_data.dart';
import '../utils/strings.dart';

class SnackPage extends StatefulWidget {
  const SnackPage({super.key});

  @override
  State<SnackPage> createState() => _SnackPageState();
}

class _SnackPageState extends State<SnackPage> {
  List<SnackModel> snackList = [];
  bool isShowing = true;
  int index = 0;
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
                    builder: (context) => const CheckoutPage(),
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
        child: Stack(
          children: [
            DefaultTabController(
              length: kSnackTabBarTitleData.length,
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
                        tabs: kSnackTabBarTitleData
                            .map((title) => Tab(
                                  text: title,
                                ))
                            .toList()),
                  ),
                  Expanded(
                      child: TabBarView(
                          children: kSnackTabBarTitleData
                              .map((text) => SnackItemsGridView(
                                    index: index,

                                    // add item
                                    onTap: () {
                                      setState(() {
                                        addSnack(0);
                                      });
                                    },
                                  ))
                              .toList()))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              //snack bottom button view
              child: SnackBottomView(
                onTap: () {
                  setState(() {
                    isShowing = !isShowing;
                  });
                },
                mySnackItems: snackList,
                isShow: isShowing,

                //remove item
                removeItem: () {
                  setState(() {
                    snackList.removeAt(0);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void addSnack(int index) {
    snackList.add(kSnackData[index]);
  }
}

//snack bottom view
class SnackBottomView extends StatefulWidget {
  final void Function() onTap;
  final bool isShow;
  final List<SnackModel> mySnackItems;
  final void Function() removeItem;
  const SnackBottomView({
    super.key,
    required this.onTap,
    required this.isShow,
    required this.mySnackItems,
    required this.removeItem,
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
            visible: widget.mySnackItems.isEmpty,
            child: const SizedBox(
              height: kMargin30,
            ),
          ),
          Visibility(
            visible: widget.mySnackItems.isNotEmpty && widget.isShow,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.mySnackItems.length,
              itemBuilder: (context, index) => AddRemoveView(
                snackModel: widget.mySnackItems[index],
                remove: widget.removeItem,
              ),
            ),
          ),
          SnackBottomButtonView(
            onTap: widget.onTap,
            isShow: widget.isShow,
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
  final void Function() onTap;
  final bool isShow;
  const SnackBottomButtonView(
      {super.key, required this.onTap, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CheckoutPage(),
            ));
      },
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
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset(
                  kSnackIcon,
                  height: kMarginLarge,
                  width: kMarginLarge,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: kMarginMedium3,
                    width: kMarginMedium3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kSnackItemCountColor,
                    ),
                    child: const Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: kMarginMedium,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: kMarginMedium3,
            ),
            IconButton(
                onPressed: onTap,
                icon: isShow
                    ? const Icon(Icons.keyboard_arrow_up_outlined)
                    : const Icon(Icons.keyboard_arrow_down_sharp)),
            const Spacer(),
            const Text(
              "2000Ks",
              style: TextStyle(
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
  final void Function() onTap;
  final int index;
  const SnackItemsGridView({
    super.key,
    required this.onTap,
    required this.index,
  });

  @override
  State<SnackItemsGridView> createState() => _SnackItemsGridViewState();
}

class _SnackItemsGridViewState extends State<SnackItemsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
          top: kMargin30,
          left: kSnackPageGridViewSpacing,
          right: kSnackPageGridViewSpacing,
          bottom: kSearchFieldHeight),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: kSnackPageGridViewSpacing,
          mainAxisSpacing: kSnackPageGridViewSpacing,
          mainAxisExtent: kSnackItemHeight),
      itemCount: kSnackData.length,
      itemBuilder: (context, index) {
        //grid view
        return SnackItemView(
          snackModel: kSnackData[index],
          onTap: widget.onTap,
        );
      },
    );
  }
}

//SnackItemView
class SnackItemView extends StatelessWidget {
  final SnackModel snackModel;
  final void Function() onTap;
  const SnackItemView(
      {super.key, required this.snackModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(
              snackModel.photo,
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
            snackModel.name,
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
            "${snackModel.price}Ks",
            style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: kTextSmall),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),

          //add button
          GestureDetector(onTap: onTap, child: const AddButton())
        ],
      ),
    );
  }
}

//add remove view
class AddRemoveView extends StatelessWidget {
  final SnackModel snackModel;
  final void Function() remove;
  const AddRemoveView(
      {super.key, required this.snackModel, required this.remove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kMargin30,
      margin: const EdgeInsets.symmetric(
          horizontal: kMarginLarge, vertical: kMarginMedium4),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(kMarginSmall),
      ),
      child: Center(
        child: Row(
          children: [
            //item name
            Text(
              snackModel.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: kTextRegular,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),

            //add remove
            GestureDetector(
              onTap: remove,
              child: Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.remove,
                  color: kSnackItemAddRemoveButtonColor,
                  size: kMarginLarge,
                ),
              ),
            ),
            const SizedBox(
              width: kMarginCardMedium2,
            ),
            const Text(
              "1",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: kTextRegular2X),
            ),
            const SizedBox(
              width: kMarginCardMedium2,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                color: kSnackItemAddRemoveButtonColor,
                size: kMarginLarge,
              ),
            ),
            const SizedBox(
              width: kMarginXXLarge3,
            ),

            //item price
            Text(
              "${snackModel.price}Ks",
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
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
