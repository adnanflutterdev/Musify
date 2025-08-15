String durationLabel(final duration) {
  return '${duration ~/ 60 < 10 ? '0' : ''}${duration ~/ 60}:${duration % 60 < 10 ? '0' : ''}${(duration % 60).toInt()}';
}
