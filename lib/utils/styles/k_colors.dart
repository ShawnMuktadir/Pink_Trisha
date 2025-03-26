import 'package:flutter/material.dart';

enum KColor {
  primary,
  secondary,
  background,
  background2,
  background3,
  background4,
  background5,
  background6,
  background7,
  backgroundDeep,
  accent,
  deepPrimary,
  softPrimary,
  midPrimary,
  red,
  blue,
  white,
  black,
  softGrey,
  grey,
  grey2,
  grey3,
  deepGrey,
  line,
  line2,
  deep,
  deep2,
  deep3,
  deep4,
  deep5,
  deep6,
  deep7,
  divider,
  fill,
  transparent,
  enableBorder,
  border,
  border2,
  fromText,
  statusBar,
  addbtn,
  card,
  formtextFill,
  dashBack,
  searchBackg,
  drawerHeader,
  dropDownfill,
  bookingText,
  homeGradientStart,
  homeGradientEnd,
  disabledText,
  cardBlueText,
}

extension KColorExtention on KColor {
  Color get color {
    switch (this) {
      case KColor.primary:
        return const Color(0xffF554B1);
      case KColor.secondary:
        return const Color(0xff2D2329);
      case KColor.accent:
        return const Color(0xffF554B1);
      case KColor.softPrimary:
        return const Color(0xFFFDB6DF);
      case KColor.midPrimary:
        return const Color(0xFFFF74C4);
      case KColor.deepPrimary:
        return const Color(0xFFF553B0);
      case KColor.background:
        return const Color(0xffFFF7FA);
      case KColor.background2:
        return const Color(0xffF7F6F7);
      case KColor.background3:
        return const Color(0xFFFBFAFA);
      case KColor.background4:
        return const Color(0xFFFDFDFD);
      case KColor.background5:
        return Color.fromARGB(255, 255, 221, 242);
      case KColor.background6:
        return const Color(0xFFF6F6F6);
      case KColor.background7:
        return const Color(0xFFEEF3F7);
      case KColor.backgroundDeep:
        return const Color(0xFF292930);
      case KColor.red:
        return const Color(0xffE42B2B);
      case KColor.blue:
        return const Color(0xFF0077FF);
      case KColor.softGrey:
        return const Color(0xff959B9A);
      case KColor.grey:
        return const Color(0xffABB3BB);
      case KColor.grey2:
        return const Color(0xFFC1C1C1);
      case KColor.grey3:
        return const Color(0xffE0E0E0);
      case KColor.deepGrey:
        return const Color(0xFF666465);
      case KColor.line:
        return const Color(0xffC3C7E5);
      case KColor.line2:
        return const Color(0xFFF1EFF1);
      case KColor.addbtn:
        return const Color(0xFFA8CFFF);
      case KColor.card:
        return const Color(0xFFFBFBFF);
      case KColor.black:
        return Colors.black;
      case KColor.deep:
        return const Color(0xFF1E263C);
      case KColor.deep2:
        return const Color(0xFF2C2328);
      case KColor.deep3:
        return const Color(0xFF666465);
      case KColor.deep4:
        return const Color(0xFF40363C);
      case KColor.deep5:
        return const Color(0x0C000000);
      case KColor.deep6:
        return const Color(0xFF2D3845);
      case KColor.deep7:
        return const Color(0xFF0D0D0D);
      case KColor.divider:
        return const Color(0xffE6E6E6);
      case KColor.enableBorder:
        return const Color(0xffDAD0DA);
      case KColor.border:
        return const Color(0xffEAECF8);
      case KColor.border2:
        return const Color(0xFFD9D0DA);
      case KColor.fill:
        return const Color.fromARGB(255, 247, 246, 246);
      case KColor.fromText:
        return const Color(0xff7B7A7A);
      case KColor.white:
        return Colors.white;
      case KColor.statusBar:
        return const Color(0xff3E95FF);
      case KColor.transparent:
        return Colors.transparent;
      case KColor.formtextFill:
        return const Color(0xffFCFCFC);
      case KColor.drawerHeader:
        return const Color(0xFF5EA7FF);
      case KColor.dropDownfill:
        return const Color(0xFFFCFCFC);
      case KColor.dashBack:
        return const Color(0xffF8F8F8);
      case KColor.searchBackg:
        return const Color(0xFFF4F8F9);
      case KColor.bookingText:
        return const Color(0xff808080);
      case KColor.homeGradientStart:
        return const Color(0xffFFF7F9);
      case KColor.homeGradientEnd:
        return const Color(0x00FDF2F5);
      case KColor.disabledText:
        return const Color(0xff737172);
      case KColor.cardBlueText:
        return const Color(0xFF0077FF);
      }
  }
}
