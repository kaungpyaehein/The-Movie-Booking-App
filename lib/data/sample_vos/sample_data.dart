import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/sample_vos/payment_option_model.dart';
import 'package:the_movie_booking_app/data/sample_vos/profile_item_model.dart';

import 'package:the_movie_booking_app/data/sample_vos/snack_model.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import 'facility_model.dart';

List<String> kSnackTabBarTitleData = [
  "All",
  "Combo",
  "Snack",
  "Pop Corn",
  "Beverage",
];

List<SnackVO> kSnackData = [
  SnackVO(name: "Potato Chips", price: 1000, image: kPotatoImage, id: 1),
  SnackVO(name: "Burger Combo", price: 5000, image: kBurgerComboImage, id: 2),
  SnackVO(name: "Coca Cola Large", price: 1000, image: kCocaColaImage, id: 3),
  SnackVO(name: "Pepsi Large", price: 1100, image: kPepsiImage, id: 4),
  SnackVO(name: "Burger Set", price: 5000, image: kBurgerComboImage, id: 5),
  SnackVO(name: "Coca Cola Small", price: 1000, image: kCocaColaImage, id: 6),
];

List<PaymentOptionModel> paymentOptionModelList = [
  PaymentOptionModel(label: kUPIText, image: kUpiImage),
  PaymentOptionModel(label: kGiftVoucherText, image: kGiftVoucherImage),
  PaymentOptionModel(label: kQuickPayText, image: kQuickPayImage),
  PaymentOptionModel(label: kCreditText, image: kCreditCardImage),
  PaymentOptionModel(label: kRedeemText, image: kRedeemImage),
  PaymentOptionModel(label: kMobileWalletText, image: kMobileWalletImage),
  PaymentOptionModel(label: kNetBankingText, image: kNetBankingImage),
];

List<FacilityModel> facilityModelList = [
  FacilityModel(label: "Parking", icon: kParkingIcon),
  FacilityModel(label: "Online Food", icon: kFoodIcon),
  FacilityModel(label: "Wheel Chair", icon: kWheelchairIcon),
  FacilityModel(label: "Parking", icon: kParkingIcon),
  FacilityModel(label: "Ticket Cancellation", icon: kCancelTicketIcon),
];

List<String> safetyDataList = [
  "Thermal Scanning",
  "Contactless Security Check",
  "Sanitization Before Every Show",
  "Package Food",
  "Disposable 3D glass",
  "Contactless Food Service",
  "Deep Cleaning of rest room"
];

List<ProfileItemModel> profileItemDateList = [
  ProfileItemModel(
    label: "Purchase History",
    iconData: Icons.history,
  ),
  ProfileItemModel(
    label: "Offer",
    iconData: Icons.percent_rounded,
  ),
  ProfileItemModel(
    label: "Gift Card",
    iconData: Icons.card_giftcard_outlined,
  ),
  ProfileItemModel(
    label: "Location",
    iconData: Icons.location_on,
  ),
  ProfileItemModel(
    label: "Payment",
    iconData: Icons.payment_outlined,
  ),
  ProfileItemModel(
    label: "Help",
    iconData: Icons.help,
  ),
  ProfileItemModel(
    label: "Logout",
    iconData: Icons.logout,
  ),
];
