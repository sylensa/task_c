import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';


bool isOnline = true;
List<BoxShadow> elevation({required Color color, required int elevation}) {
  return [
    BoxShadow(
        color: color.withOpacity(0.6),
        offset: Offset(0.0, 4.0),
        blurRadius: 3.0 * elevation,
        spreadRadius: -1.0 * elevation),
    BoxShadow(
        color: color.withOpacity(0.44),
        offset: Offset(0.0, 1.0),
        blurRadius: 2.2 * elevation,
        spreadRadius: 1.5),
    BoxShadow(
        color: color.withOpacity(0.12),
        offset: Offset(0.0, 1.0),
        blurRadius: 4.6 * elevation,
        spreadRadius: 0.0),
  ];
}

const Color sBlueGray = Color(0xFFb4bbc9);
const Color basaltGray200 = Color(0xFFdadcdf);
const Color basaltGray300 = Color(0xFFADB5BD);
const Color basaltGray400 = Color(0xFF9ea6ad);
const Color basaltGray500 = Color(0xFF757b81);
const Color basaltGray600 = Color(0xFF5b5f64);
const Color basaltGray700 = Color(0xFF495057);
const Color darkColor = Color(0xFF253341);

Color sDarkGray = dDarkText.withOpacity(0.8);
Color sGray = dDarkText.withOpacity(0.4);
const dDarkText = Color(0xFF1D1D1D);
const Color dTurquoise = Color(0xFF0CB8B6);
const Color dPurple = Color(0xFF9F5DE2);
const Color dMiddleBlue = Color(0xFF5C86CE);
const Color dPurpleGradientLeft = Color(0xFF7A08FA);
const Color dPurpleGradientRight = Color(0xFFAD3BFC);
const Color dRedGradientRight = Color(0xFFE5366A);
const Color dRedGradientLeft = Color(0xFFFE806F);

const appLightGray = Color(0xFFE7ECF2);
const appMainLimeGreen = Color(0xFF96a038);
const appMainLimeGreen2 = Color(0xFF75bf43);
const appMainGreen = Color(0xFF00C853);
const appMainPink = Color(0xFFb81e4f);
const appMainViolet = Color(0xFF87449a);
const appMainDarkGrey = Color(0xFF253d47);
const appMainOrange = Color(0xFFba5927);
const appGray = Color(0xFFadb4b9);
const appDarkText = Color(0xFF2F2F2F);





Widget displayLocalImage(String filePath,
    {double radius = 30.0, double? height, double? width}) {
  File file = new File(filePath);
  return radius > 20
      ? CircleAvatar(
          backgroundColor: basaltGray200,
          backgroundImage: (filePath.isEmpty
              ? AssetImage('images/user_placeholder.png')
              : FileImage(file)) as ImageProvider<Object>?,
          radius: radius,
        )
      : Image(
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
          image: (filePath.isEmpty
              ? AssetImage('images/user_placeholder.png')
              : FileImage(file)) as ImageProvider<Object>,
        );
}

Widget displayLocalImageDevice(String filePath,
    {double radius = 30.0, double? height, double? width}) {
  File file =  File(filePath);
  return radius > 20
      ? CircleAvatar(
    backgroundColor: basaltGray200,
    backgroundImage: (filePath.isEmpty
        ? AssetImage('assets/images/default.png')
        : FileImage(file)) as ImageProvider<Object>?,
    radius: radius,
  )
      : Image(
    fit: BoxFit.fitWidth,
    height: height,
    width: width,
    image: (filePath.isEmpty
        ? AssetImage('assets/images/default.png')
        : FileImage(file)) as ImageProvider<Object>,
  );
}
Widget progress({double size = 30}) {
  return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
          backgroundColor: basaltGray200,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xFF00C9B9),
          )));
}

Widget sText(String? word,
    {double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = basaltGray700,
    TextAlign align = TextAlign.left,
    int maxLines = 5,
    double? lHeight = 1.2,
    String family = 'Poppins',
    FontStyle style = FontStyle.normal,
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      height: lHeight,
      fontStyle: style,
      color: color,
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      shadows:
          shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget sText2(String? word,
    {double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = basaltGray700,
    TextAlign align = TextAlign.left,
    int maxLines = 5,
    double? lHeight = 1.2,
    String family = 'ProximaRegular',
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      height: lHeight,
      color: color,
      fontFamily: 'ProximaRegular',
      fontSize: size,
      fontWeight: weight,
      shadows:
          shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget solonOutlineButton({
  required Widget content,
  required Function onPressed,
  textColor: Colors.white,
  double z: 16,
  double radius: 5,
  int shadowStrength: 1,
  double borderWidth: 1,
  double height: 60,
  EdgeInsetsGeometry? padding,
  Color outlineColor: const Color(0xFFf2f2f2),
  Color backgroundColor: Colors.white,
  String family = 'ProximaRegular',
}) {
  return Container(
    height: height,
    decoration: shadowStrength > 0
        ? BoxDecoration(
            boxShadow:
                elevation(color: basaltGray200, elevation: shadowStrength),
            borderRadius: BorderRadius.circular(radius))
        : BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: outlineColor, width: borderWidth)),
      ),
      onPressed: () => onPressed(),
      child: content,
    ),
  );
}

Widget dPurpleGradientButton(
    {required Widget content,
    required Function onPressed,
    double radius: 5,
    double height: 50,
    EdgeInsetsGeometry? padding,
    List<Color> colors: const [dPurpleGradientLeft, dPurpleGradientRight],
    gradientDirection: 'left_right'}) {
  return SizedBox(
    height: height,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientDirection == 'left_right'
                ? Alignment.centerLeft
                : Alignment.topCenter,
            end: gradientDirection == 'left_right'
                ? Alignment.centerRight
                : Alignment.bottomCenter,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(radius)),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//          backgroundColor: col,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: () => onPressed(),
        child: content,
      ),
    ),
  );
}

Future goTo(BuildContext context, Widget target,
    {bool replace = false,
    PageTransitionType anim = PageTransitionType.size,
    int millis = 200,
    bool opaque = true}) {
  if (!opaque) {
    if (!replace) {
      return Navigator.of(context).push(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
              target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    } else {
      return Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
              target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    }
  }
  if (!replace) {
    return Navigator.push(
        context,
        PageTransition(
            type: anim,
            duration: Duration(milliseconds: millis),
            alignment: Alignment.bottomCenter,
            child: target));
  } else
    return Navigator.pushReplacement(
        context,
        PageTransition(
            type: anim,
            duration: Duration(milliseconds: millis),
            alignment: Alignment.bottomCenter,
            child: target));
}

TextStyle appStyle(
    {double size = 16,
    Color? col = dDarkText,
    FontWeight weight = FontWeight.w400,
    String family = "Poppins"}) {
  return TextStyle(
      fontFamily: family, fontWeight: weight, fontSize: size, color: col);
}

EdgeInsets noPadding() {
  return EdgeInsets.zero;
}

EdgeInsets appPadding(double size) {
  return EdgeInsets.all(size);
}
InputDecoration textDecorSuffix({Color fillColor = Colors.white,String? hint, Widget? icon, Widget? suffIcon,Color? suffIconColor, String prefix = '', String suffix = '', bool enabled = true, Color hintColor = Colors.grey, double hintSize = 16, bool showBorder = true, String label = '', double size = 40,double top = 12.0,double radius = 0}) {
  return new InputDecoration(
    suffixIcon: suffIcon,
    prefixIcon: icon,
    prefixText: prefix,
    suffixText: suffix,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(size)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText, width: 1),
      borderRadius:  BorderRadius.all(Radius.circular(size)),
    ),
    labelStyle: appStyle(size: hintSize, col: hintColor),
    labelText: label,
    filled: true,
    fillColor: fillColor,
    contentPadding: EdgeInsets.fromLTRB(20.0, top, 0.0, 12.0),
  );
}

InputDecoration textDecor(
    {String hint = '',
    Widget? icon,
    String prefix = '',
    Widget? suffix,
    Widget? suffixIcon,
    bool enabled = true,
    Color? hintColor = basaltGray500,
    double hintSize = 16,
    bool showBorder = true,
    double radius = 4,
    String label = '',
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0)}) {
  return new InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffix: suffix,
    suffixIcon: suffixIcon,
    hintText: hint,
    alignLabelWithHint: true,
    isDense: true,

    floatingLabelBehavior: (label.isNotEmpty && hint.isNotEmpty)
        ? FloatingLabelBehavior.never
        : FloatingLabelBehavior.auto,
    hintStyle: appStyle(size: hintSize, col: hintColor),
//    border: UnderlineInputBorder(
//      borderSide: BorderSide(color: theColor),
//    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    labelText: label,
    labelStyle: appStyle(size: hintSize, col: hintColor),
//    filled: true,
//    fillColor: Colors.white,
    contentPadding: padding,
  );
}

InputDecoration textDecorNoBorder(
    {String? hint,
    String prefix = '',
    Widget? suffix,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    double hintSize = 16,
    Color? hintColor,
    String labelText = '',
    String family = "Poppins",
    FontWeight hintWeight: FontWeight.normal,
    Color? fill,
    Color borderColor = Colors.black,
    double radius = 4,
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0)}) {
  return new InputDecoration(
    prefixText: prefix,
    suffix: suffix,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintText: hint,
    labelText: labelText,
    hintStyle: appStyle(
      size: hintSize,
      col: hintColor,
      weight: hintWeight,
      family: family,
    ),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusColor: dPurple,
    enabled: enabled,
    labelStyle: appStyle(size: hintSize, col: hintColor),
    filled: true,
    fillColor: fill,
    contentPadding: padding,
  );
}

showDialogOk(
    {String? message,
    String? title = "Alert",
    BuildContext? context,
    Widget? target,
    bool? status = false,
    bool replace = false,
    bool dismiss = true}) {
  // flutter defined function
  showDialog(
    context: context!,
    barrierDismissible: dismiss,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("$title"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            child: new Text("Ok"),
            onPressed: () {
              if (status!) {
                Navigator.pop(context);
                goTo(context, target!, replace: replace);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

showSuccessfulDialog(
    {String? message, BuildContext? context, Widget? target, bool? status}) {
  // flutter defined function
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            child: new Text("Ok"),
            onPressed: () {
              if (status!) {
                Navigator.pop(context);
                goTo(context, target!, replace: false);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

showDialogYesNo(
    {String? message,
      String? title,
    BuildContext? context,
    Widget? target,
    bool replace = false}) {
  // flutter defined function
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("$title"),
        content: Text(message!),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          MaterialButton(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: new Text("Yes"),
            onPressed: () {
              print("hey");
              Navigator.pop(context);
              goTo(context, target!, replace: replace);
            },
          ),
        ],
      );
    },
  );
}

appWidth(con) {
  return MediaQuery.of(con).size.width;
}

appHeight(con) {
  return MediaQuery.of(con).size.height;
}

List<BoxShadow> appShadow(
    Color col, double offset, double blur, double spread) {
  return [
    BoxShadow(
        blurRadius: blur,
        color: col,
        offset: Offset(0, 2.0),
        spreadRadius: spread),
  ];
}




EdgeInsets topPadding(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomPadding(double size) {
  return EdgeInsets.only(bottom: size);
}

EdgeInsets leftPadding(double size) {
  return EdgeInsets.only(left: size);
}

EdgeInsets rightPadding(double size) {
  return EdgeInsets.only(right: size);
}

EdgeInsets horizontalPadding(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalPadding(double size) {
  return EdgeInsets.symmetric(vertical: size);
}

properCase(String txt) {
  return txt.titleCase;
}

capCase(String txt) {
  return txt.toUpperCase();
}

sentenceCase(String txt) {
  if (txt.isEmpty) return txt;
  return txt.sentenceCase;
}


Map replaceNulls(Map m) {
  for (var i in m.keys) {
    if (m[i] is String) {
      if (m[i] == "null") {
        m[i] = '';
      }
    } else if (m[i] == Null) {
      m[i] = '';
    } else {
      m[i] = jsonEncode(m[i]);
    }
  }
  return m;
}

bool appIsEmpty(value) {
  return value.toString() == '' || value == null || value == 'null';
}

Map stripNulls(dynamic v) {
  Map m = v.toMap();
  Map<String, String> finalMap = v.toMap();
  for (var i in m.keys) {
    if (m[i] == "null") {
      finalMap.remove(i);
    }
  }
  return finalMap;
}


navigateTo(BuildContext context, Widget target,
    {bool replace = false,
    PageTransitionType anim = PageTransitionType.fade,
    int millis = 300,
    bool opaque = false}) {
  if (!replace) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
            target,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        }));
  } else
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.size,
            duration: Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            child: target));
}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    if (diffInHours < 0) {
      diffInHours = diffInHours * -1;
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'min';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'hr';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'day';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'wk';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'mon';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'yr';
      }
      timeAgo = timeValue.toString() + ' ' + timeUnit;
      timeAgo += timeValue > 1 ? '' : '';

      return 'in ' + timeAgo;
    } else {
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'min';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'hr';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'day';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'wk';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'mon';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'yr';
      }
      timeAgo = timeValue.toString() + ' ' + timeUnit;
      timeAgo += timeValue > 1 ? '' : '';

      return timeAgo;
    }
  }
}


generateRandom() {
  var rng = Random();
  var code = rng.nextInt(900000) + 100000;

  return code;
}

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}




showLoaderDialog(BuildContext context, {String? message = "loading..."}) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 7),
              child: Text(
                message!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



