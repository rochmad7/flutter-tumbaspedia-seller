part of 'widgets.dart';

class SortOption {
  SortOption({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);
  final dynamic id;
  final String name;
}

class SortGroup extends StatelessWidget {
  const SortGroup({
    @required this.options,
    @required this.selectedOptionId,
    this.onOptionTap,
    Key key,
  })  : assert(options != null),
        assert(selectedOptionId != null),
        super(key: key);

  final List<SortOption> options;
  final dynamic selectedOptionId;
  final ValueChanged<SortOption> onOptionTap;

  @override
  Widget build(BuildContext context) => _OptionList(
    options: options,
    selectedOptionId: selectedOptionId,
    onOptionTap: onOptionTap,
  );
}

class _OptionList extends StatelessWidget {
  const _OptionList({
    @required this.selectedOptionId,
    @required this.onOptionTap,
    this.options,
    Key key,
  })  : assert(selectedOptionId != null),
        assert(onOptionTap != null),
        super(key: key);

  final List<SortOption> options;
  final dynamic selectedOptionId;
  final ValueChanged<SortOption> onOptionTap;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 10,
    children: [
      ...options.map(
            (option) {
          final isItemSelected = selectedOptionId == option.id;
          return ChoiceChip(
            label: Text(option.name,
                style:
                isItemSelected ? whiteFontStyle12 : blackFontStyle12),
            onSelected:
            onOptionTap != null ? (_) => onOptionTap(option) : null,
            selected: isItemSelected,
            backgroundColor: Colors.grey[300],
            selectedColor: mainColor,
          );
        },
      ).toList(),
    ],
  );
}

class SortMethodGroup extends StatelessWidget {
  const SortMethodGroup({
    @required this.selectedItem,
    this.onOptionTap,
    Key key,
  }) : super(key: key);

  final ValueChanged<SortOption> onOptionTap;
  final SortMethod selectedItem;
  @override
  Widget build(BuildContext context) => SortGroup(
    options: SortMethod.values
        .map(
          (sortMethod) => SortOption(
        id: sortMethod,
        name: sortMethod == SortMethod.acak
            ? 'Acak'
            : sortMethod == SortMethod.terlaris
            ? 'Terlaris'
            : sortMethod == SortMethod.termurah
            ? 'Termurah'
            : 'Terbaru',
      ),
    )
        .toList(),
    selectedOptionId: selectedItem,
    onOptionTap: onOptionTap,
  );
}