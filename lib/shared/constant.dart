part of 'shared.dart';

void saveUserData(
    {String email, String password, String token, bool isValid}) async {
  final _storage = const FlutterSecureStorage();
  _storage.write(key: 'shop_email', value: email);
  _storage.write(key: 'shop_password', value: password);
  _storage.write(key: 'shop_token', value: token);
  _storage.write(key: 'shop_isValid', value: isValid.toString());
}

void removeUserData() async {
  final _storage = const FlutterSecureStorage();
  _storage.delete(key: 'shop_email');
  _storage.delete(key: 'shop_password');
  _storage.delete(key: 'shop_token');
}

String tokenAPI = "VUJDZFIYZD6TJ4DFDGULFGXZDPOVI94R";

// String baseURLAPI = 'http://10.0.2.2:3000/api';
String baseURLAPI = 'https://dev.tumbaspedia.my.id/api';

Color mainColor = Color(0xff541690);
// Color mainColor = "032339".toColor();
Color greyColor = "8D92A3".toColor();
Color secondaryColor = "FFC700".toColor();
const kSecondaryColor = Color(0xFF979797);
const kPrimaryLightColor = Color(0xFFFFECDF);

Widget loadingIndicator = SpinKitWave(
  size: 25,
  color: mainColor,
);

TextStyle redFontStyle = GoogleFonts.roboto().copyWith(color: Colors.red);
TextStyle orangeFontStyle =
    GoogleFonts.roboto().copyWith(color: Colors.orange);
TextStyle greenFontStyle = GoogleFonts.roboto().copyWith(color: Colors.green);
TextStyle greyFontStyle = GoogleFonts.roboto().copyWith(color: greyColor);
TextStyle greyFontStyle12 =
    GoogleFonts.roboto().copyWith(color: greyColor, fontSize: 12);
TextStyle greyFontStyle13 =
    GoogleFonts.roboto().copyWith(color: greyColor, fontSize: 13);
TextStyle blackFontStyle = GoogleFonts.roboto().copyWith(color: Colors.black);
TextStyle blackFontStyle1 = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.roboto().copyWith(color: Colors.black);
TextStyle blackFontStyle12 =
    GoogleFonts.roboto().copyWith(color: Colors.black, fontSize: 12);
TextStyle whiteFontStyle = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle whiteFontStyle1 = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle2 = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle3 = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle whiteFontStyle12 =
    GoogleFonts.roboto().copyWith(color: Colors.white, fontSize: 12);
TextStyle orangeFontStyle2 = GoogleFonts.roboto().copyWith(
    color: Colors.orange,
    fontSize: defaultFontSize,
    fontWeight: FontWeight.bold);

TextStyle hintStyle = GoogleFonts.roboto().copyWith(
  color: Color(0xFF666666),
  fontSize: defaultFontSize,
);

TextStyle titleListStyle = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14);

TextStyle textListStyle = blackFontStyle2.copyWith(fontSize: 15);

TextStyle sectionTitleStyle =
    GoogleFonts.roboto().copyWith(fontSize: 16, fontWeight: FontWeight.w600);

String getFormatRupiah(int price, bool isFull) {
  if (price > 999999 && !isFull) {
    return 'Rp. ' + formatRupiah(price);
  }
  return NumberFormat.currency(
          locale: 'id-ID', symbol: 'Rp. ', decimalDigits: 0)
      .format(price);
}

String formatRupiah(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} Ribu";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} Ribu";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} Juta";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} Miliar";
  } else {
    return num.toString();
  }
}

String formatNumber(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} rb";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} rb";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} jt";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} m";
  } else {
    return num.toString();
  }
}

String convertDate(DateTime dateTime, bool isFull) {
  if (isFull) {
    return DateFormat('EEEE, d MMM yyyy', 'id_ID').format(dateTime);
  } else {
    return DateFormat('EE, d MMM yyyy', 'id_ID').format(dateTime);
  }
}

String convertTime(DateTime dateTime) {
  String date = DateFormat('HH:mm', 'id_ID').format(dateTime);

  return date + ' WIB';
}

bool containsIgnoreCase(String firstString, String secondString) {
  firstString = firstString.toLowerCase();
  return firstString.contains(secondString) ? true : false;
}

TimeOfDay timeConvert(String normTime) {
  return TimeOfDay(
      hour: int.parse(normTime.split(":")[0]),
      minute: int.parse(normTime.split(":")[1]));
}

Widget forgotPassword() {
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
        onTap: () {
          Get.to(
            () => ForgotPasswordPage(),
          );
        },
        child: Text("Lupa kata sandi?", style: blackFontStyle)),
  );
}

void snackBar(String title, String subtitle, String type) {
  Get.snackbar(
    "",
    "",
    backgroundColor: type == 'success'
        ? "4A934A".toColor()
        : type == 'error'
            ? "D9435E".toColor()
            : type == 'warning'
                ? "#fff3cd".toColor()
                : Colors.white,
    icon: Icon(
        type == 'success'
            ? MdiIcons.checkCircleOutline
            : type == 'error'
                ? MdiIcons.closeCircleOutline
                : MdiIcons.alertCircleOutline,
        color:
            type == 'success' || type == 'error' ? Colors.white : Colors.black),
    titleText: Text(
      title,
      style: GoogleFonts.roboto(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      subtitle,
      style: GoogleFonts.roboto(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black),
    ),
  );
}

String numberFormatDecimal(int number) {
  var formatter = NumberFormat('###,###');
  return formatter.format(number);
}

const double defaultMargin = 24;
const double defaultFontSize = 18;
const double defaultIconSize = 17;
