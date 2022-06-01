part of 'shared.dart';

void saveUserData(
    {String email, String password, String token, bool isValid}) async {
  final _storage = const FlutterSecureStorage();
  _storage.write(key: 'email', value: email);
  _storage.write(key: 'password', value: password);
  _storage.write(key: 'token', value: token);
  _storage.write(key: 'isValid', value: isValid.toString());
}

void removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('emailshop');
  prefs.remove('passwordshop');
  prefs.remove('tokenshop');
  prefs.remove('isReject');
  prefs.remove('isValid');
  prefs.remove('nib');
}

String tokenAPI = "VUJDZFIYZD6TJ4DFDGULFGXZDPOVI94R";

// String baseURL = 'http://192.168.81.14:8000/';
String baseURL = 'https://betav2.doltinuku.id/';
String baseURLStorage = baseURL + 'storage/';
// String baseURLAPI = 'http://10.0.2.2:3000/api';
String baseURLAPI = 'http://192.168.81.33:3000/api';

Color mainColor = "032339".toColor();
Color greyColor = "8D92A3".toColor();
Color secondaryColor = "FFC700".toColor();
const kSecondaryColor = Color(0xFF979797);
const kPrimaryLightColor = Color(0xFFFFECDF);

Widget loadingIndicator = SpinKitWave(
  size: 25,
  color: mainColor,
);

TextStyle redFontStyle = GoogleFonts.poppins().copyWith(color: Colors.red);
TextStyle orangeFontStyle =
    GoogleFonts.poppins().copyWith(color: Colors.orange);
TextStyle greenFontStyle = GoogleFonts.poppins().copyWith(color: Colors.green);
TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle greyFontStyle12 =
    GoogleFonts.poppins().copyWith(color: greyColor, fontSize: 12);
TextStyle greyFontStyle13 =
    GoogleFonts.poppins().copyWith(color: greyColor, fontSize: 13);
TextStyle blackFontStyle = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle blackFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle blackFontStyle12 =
    GoogleFonts.poppins().copyWith(color: Colors.black, fontSize: 12);
TextStyle whiteFontStyle = GoogleFonts.poppins().copyWith(color: Colors.white);
TextStyle whiteFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.white);
TextStyle whiteFontStyle12 =
    GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 12);
TextStyle orangeFontStyle2 = GoogleFonts.poppins().copyWith(
    color: Colors.orange,
    fontSize: defaultFontSize,
    fontWeight: FontWeight.bold);

TextStyle hintStyle = GoogleFonts.poppins().copyWith(
  color: Color(0xFF666666),
  fontSize: defaultFontSize,
);

TextStyle titleListStyle = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14);

TextStyle textListStyle = blackFontStyle2.copyWith(fontSize: 15);

TextStyle sectionTitleStyle =
    GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w600);

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
    return DateFormat('EEEE, d MMM, yyyy').format(dateTime);
  } else {
    return DateFormat('EE, d MMM, yyyy').format(dateTime);
  }
}

String convertTime(DateTime dateTime) {
  DateFormat dateFormat = DateFormat('').add_jms();
  return dateFormat.format(dateTime);
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
        child: Text("Lupa password?", style: blackFontStyle)),
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
      style: GoogleFonts.poppins(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      subtitle,
      style: GoogleFonts.poppins(
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
const double defaultFontSize = 15;
const double defaultIconSize = 17;
