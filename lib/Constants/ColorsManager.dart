import 'package:flutter/material.dart';

const String dummyimage =
    'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=836&q=80';
const Color cappbarcolor = Color(0XFF151515);
const Color cdashboardheadingcolor = Color(0XFF454545);
const Color backgroundColor = Color(0XFFF9F9F9);
const Color ratingcolor = Color(0XFFF5E072);
const Color white = Color(0XFFFFFFFF);
const Color black = Color(0XFF545454);
const Color red = Colors.red;
const Color greentextgraient = Color(0XFF227B69);
const Color bluetextgraient = Color(0XFF586E71);
const Color redtextgraient = Color(0XFFB64D3F);
const Color netearningtext = Color(0XFF717880);
const Color primarycolor = Color(0XFF717880);
const Color lightprimarycolor = Color(0XFF97A8A8);
const Color lightblue = Color(0XFF697B90);
const Color offwhite = Color(0XFFF1F1F1);
const Color cancelled = Color(0XFFB64D3F);
const Color green = Color(0XFF227B69);
const Color greylight = Color(0XFFC2C2C2);
const Color primaryColor = Color(0XFF97a8a8);
Color logoutbuttoncolor = const Color(0XFF697B90).withOpacity(0.25);
const Color appBarTextColor = Color(0xFF545454);
const Color scaffoldBookingScreenColor = Color(0xFFE5E5E5);
const Color textColor = Color(0xFF696969);
const Color textColorTwo = Color(0xFF999999);
const Color dividerSelectedColor = Color(0xFFEEEEEE);
const Color borderColor = Color(0xFFD8D8D8);
const Color textHintColor = Color(0xFFC6C6C6);
const Color textColorThree = Color(0xFF717880);

class ColorManager {
  static Color lightgrey = const Color.fromARGB(255, 63, 61, 61);
  static Color mediumgrey = Colors.grey.withOpacity(0.1);
  static Color grey = Colors.grey;
  static Color deeppurple = Colors.deepPurple;

  /// MAin Colors
  static Color primaryColor = const Color(0XFF97a8a8);
  static Color secondaryColor = const Color(0XFF717880);

  static Color lightcolor = const Color(0XFFe8eaea);
  static Color black = HexColor.fromHex('#000000');
  static Color white = HexColor.fromHex('#FFFFFF');

  static List<BoxShadow> boxShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 0.5,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ];
  }
}

List<BoxShadow> containerboxShadow() {
  return [
    BoxShadow(
      color: const Color(0XFFA4A4A4).withOpacity(0.5),
      spreadRadius: 0,
      blurRadius: 0.3,
      offset: const Offset(0, 0), // changes position of shadow
    ),
  ];
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
