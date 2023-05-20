part of 'widgets.dart';

class TextFieldDefault extends StatelessWidget {
  final Function press;
  final IconData icon;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final bool isObscureText;
  final bool isPrefixIcon;
  final bool isMaxLines;
  final bool isSuffixIcon;
  final bool enableInteractiveSelection;
  final Function suffixIcon;
  final bool isPriceType;
  final bool isNumberType;

  TextFieldDefault({
    this.icon,
    this.press,
    this.isPrefixIcon = true,
    this.isMaxLines = false,
    this.isObscureText = false,
    this.suffixIcon,
    this.maxLines,
    this.isSuffixIcon = false,
    this.hintText,
    this.enableInteractiveSelection = true,
    this.controller,
    this.isPriceType = false,
    this.isNumberType = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Text is empty';
        }
        return null;
      },
      keyboardType: isNumberType ? TextInputType.number : TextInputType.text,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: press != null ? press : null,
      obscureText: isObscureText,
      maxLines: (!isMaxLines) ? 1 : maxLines,
      style: blackFontStyle3,
      controller: controller,
      showCursor: true,
      inputFormatters: isPriceType ? [ThousandsFormatter()] : [],
      decoration: InputDecoration(
        errorStyle: redFontStyle,
        contentPadding: EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 0.3),
        ),
        filled: true,
        prefixIcon: (!isPrefixIcon)
            ? null
            : Icon(
                icon,
                color: Color(0xFF666666),
                size: defaultIconSize,
              ),
        suffixIcon: (!isSuffixIcon)
            ? null
            : IconButton(
                onPressed: suffixIcon,
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xFF666666),
                  size: defaultIconSize,
                ),
              ),
        fillColor: Color(0xFFF2F3F5),
        hintStyle: hintStyle,
        hintText: hintText,
      ),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newString = convertThousandFormatter(newValue);
    return newValue.copyWith(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length));
  }

  String convertThousandFormatter(TextEditingValue newValue) {
    final nonDigitsRegExp = RegExp(r'[^\d]+');
    String newString = newValue.text.replaceAll(nonDigitsRegExp, '');
    final regEx = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final matches = regEx.allMatches(newString);
    int offset = 0;
    for (Match match in matches) {
      newString = newString.replaceRange(
          match.start + offset, match.end + offset, '${match.group(0)}.');
      offset++;
    }
    return newString;
  }
}
