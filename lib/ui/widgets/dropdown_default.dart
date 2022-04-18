part of 'widgets.dart';

class DropdownDefault extends StatelessWidget {
  final Function onChanged;
  final Category selectedCategory;
  final String selectedItem;
  final List<DropdownMenuItem<String>> items;
  final bool isCategory;
  final List<DropdownMenuItem<Category>> categoryItems;
  DropdownDefault(
      {this.onChanged,
      this.isCategory = true,
      this.selectedCategory,
      this.selectedItem,
      this.categoryItems,
      this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
      child: DropdownButton(
          value: isCategory ? selectedCategory : selectedItem,
          isExpanded: true,
          underline: SizedBox(),
          items: isCategory ? categoryItems : items,
          onChanged: onChanged),
    );
  }
}
