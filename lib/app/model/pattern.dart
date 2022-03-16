class PatternData {
  late double patternOpacity;
  late double patternSize;
  late String? pattern;

  PatternData(
      {required this.patternOpacity,
      required this.patternSize,
      required this.pattern});

  double get patternSizeGet => patternSize;

  set patternSizeSet(double value) {
    patternSize = value;
  }

  String? get patternGet => pattern;

  set patternSet(String value) {
    pattern = value;
  }

  double get patternOpacityGet => patternOpacity;

  set patternOpacitySet(double value) {
    patternOpacity = value;
  }

  PatternData copyWith({
    double? patternOpacity,
    double? patternSize,
    String? pattern,
  }) {
    return PatternData(
      patternOpacity: patternOpacity ?? this.patternOpacity,
      patternSize: patternSize ?? this.patternSize,
      pattern: pattern ?? this.pattern,
    );
  }
}
