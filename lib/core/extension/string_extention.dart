extension StringExtention on String {
  String capitalizeString(String string) {
    final wordList = string.split(' ');
    List<String> capitalizedString = [];

    for (String s in wordList) {
      if (s.isNotEmpty) {
        if (s.length == 1) {
          capitalizedString.add(s.toUpperCase());
        } else {
          capitalizedString.add('${s[0].toUpperCase()}${s.substring(1)}');
        }
      }
    }

    return capitalizedString.join(' ');
  }

  String get capitalize => capitalizeString(this);
}
