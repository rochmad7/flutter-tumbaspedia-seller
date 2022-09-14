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
  TextFieldDefault(
      {this.icon,
      this.press,
      this.isPrefixIcon = true,
      this.isMaxLines = false,
      this.isObscureText = false,
      this.suffixIcon,
      this.maxLines,
      this.isSuffixIcon = false,
      this.hintText,
      this.enableInteractiveSelection = true,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Text is empty';
        }
        return null;
      },
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: press != null ? press : null,
      obscureText: isObscureText,
      maxLines: (!isMaxLines) ? 1 : maxLines,
      style: blackFontStyle3,
      controller: controller,
      showCursor: true,
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
