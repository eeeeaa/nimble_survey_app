enum DisplayType {
  defaults,
  intro,
  outro,
  choice,
  thumpsUp,
  smiley,
  heart,
  star,
  nps,
  slider,
  dropdown,
  textField,
  textarea,
}

enum PickType { none, one, any }

extension PickTypeExtension on PickType {
  static PickType fromString(String value) {
    return PickType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => PickType.none,
    );
  }
}

extension DisplayTypeExtension on DisplayType {
  String get value {
    switch (this) {
      case DisplayType.defaults:
        return 'default';
      case DisplayType.thumpsUp:
        return 'thumpsup';
      case DisplayType.textField:
        return 'textfield';
      default:
        return name.toLowerCase();
    }
  }

  static DisplayType fromString(String value) {
    return DisplayType.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => DisplayType.defaults,
    );
  }
}
