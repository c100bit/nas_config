extension StringExtension on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String cutByLength({int length = 100, String tail = '...'}) =>
      this.length > length ? '${substring(0, length)}...' : this;
}
