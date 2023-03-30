enum PositionItemType {
  log,
  position,
}

class PositionItem {
  final PositionItemType type;
  final String displayValue;

  PositionItem(this.type, this.displayValue);
}
