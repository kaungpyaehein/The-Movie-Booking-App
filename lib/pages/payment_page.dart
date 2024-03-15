import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:the_movie_booking_app/pages/ticket_information_page.dart';

import '../data/sample_vos/sample_data.dart';
import '../data/vos/seat_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../utils/strings.dart';

class PaymentPage extends StatefulWidget {
  final List<SeatVO> selectedSeatList;
  final String totalSeatPrice;
  final String date;
  final TimeslotVO timeslotVO;
  final List<SnackVO> snackList;
  final String cinemaName;
  final MovieVO movieVO;
  const PaymentPage(
      {super.key,
      required this.selectedSeatList,
      required this.totalSeatPrice,
      required this.date,
      required this.timeslotVO,
      required this.snackList,
      required this.cinemaName, required this.movieVO});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<PaymentTypeVO> paymentMethods = [];
  final MovieBookingModel model = MovieBookingModel();

  @override
  void initState() {
    model.getPaymentTypes().then((paymentTypes) {
      print(paymentTypes.toString());
      setState(() {
        paymentMethods = paymentTypes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: kBackgroundColor,
        title: const Text(
          kPaymentText,
          style: TextStyle(
              color: Colors.white,
              fontSize: kAppBarTitleFontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ApplyCouponView(),
            //spacer
            const SizedBox(
              height: kMarginXLarge,
            ),

            //choose payment method view
            paymentMethods.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ChoosePaymentMethodsView(
                    paymentMethods: paymentMethods,
                    onTap: (paymentId) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketInformationPage(
                                selectedSeatList: widget.selectedSeatList,
                                totalSeatPrice: widget.totalSeatPrice,
                                date: widget.date,
                                timeslotVO: widget.timeslotVO,
                                snackList: widget.snackList,
                                cinemaName: widget.cinemaName,
                                paymentId: paymentId,
                            movieVO: widget.movieVO,),
                          ));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class ApplyCouponView extends StatelessWidget {
  const ApplyCouponView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kMarginXLarge2, vertical: kMarginXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //name input field
          NameInputView(),

          SizedBox(
            height: kMarginXLarge,
          ),

          //apply coupon button view
          ApplyCouponButtonView(),
        ],
      ),
    );
  }
}

class ChoosePaymentMethodsView extends StatelessWidget {
  final List<PaymentTypeVO> paymentMethods;
  final Function(int paymentId) onTap;
  const ChoosePaymentMethodsView({
    super.key,
    required this.paymentMethods,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose your payment type",
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: kText18),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: kMarginMedium4),
            itemCount: paymentMethods.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: kMarginMedium2),
              child: PaymentOptionItemView(
                label: paymentMethods[index].title ?? "",
                image: paymentOptionModelList[index].image,
                onTap: () {
                  onTap(paymentMethods[index].id!);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

//name input view
class NameInputView extends StatelessWidget {
  const NameInputView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMargin60,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kMarginMedium),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kMarginMedium),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),

            // helperText: "Your Name",
            labelText: kYourNameText,
            labelStyle: const TextStyle(color: kPrimaryColor),
            hintText: kEnterYourNameText,
            hintStyle: const TextStyle(
                color: kDividerColor, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

//payment Option view
class PaymentOptionItemView extends StatelessWidget {
  final String label;
  final String image;
  final void Function() onTap;
  const PaymentOptionItemView(
      {super.key,
      required this.label,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: kMargin50,
        padding: const EdgeInsets.symmetric(
            horizontal: kMarginMedium2, vertical: kMarginMedium2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          boxShadow: const [
            BoxShadow(
              color: kPaymentOptionButtonBoxShadowColor,
              blurRadius: kMarginSmall,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
          color: kPaymentOptionButtonColor,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: kMargin30,
              width: kMargin30,
            ),
            const SizedBox(
              width: kMarginMedium2,
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: kMarginMedium4,
            ),
            const SizedBox(
              width: kMarginMedium,
            )
          ],
        ),
      ),
    );
  }
}

//apply coupon button view
class ApplyCouponButtonView extends StatelessWidget {
  const ApplyCouponButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: const Size(double.infinity, kApplyCouponButtonHeight),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kMarginMedium))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kPercentageIcon,
              height: kSnackPageGridViewSpacing,
              width: kSnackPageGridViewSpacing,
            ),
            const SizedBox(
              width: kMarginMedium2,
            ),
            const Text(
              "Unlock Offer or Apply PromoCode",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
