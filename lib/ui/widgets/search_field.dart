part of 'widgets.dart';

class SearchField extends StatelessWidget {
  final Function press;
  final Function onChanged;
  final String title;
  final TextEditingController searchController;

  SearchField(
      {this.title = "Cari sesuatu",
      this.onChanged,
      this.searchController,
      this.press});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(7.0),
        child: TextField(
          onChanged: onChanged,
          style: blackFontStyle3,
          controller: searchController,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
            hintText: title,
            hintStyle: hintStyle,
            suffixIcon: GestureDetector(
              onTap: press,
              child: Material(
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
