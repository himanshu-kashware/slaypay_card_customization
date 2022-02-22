

class PatternDetail {
  late String? _pattern_data;
  late bool _isSelected;

  PatternDetail(this._pattern_data, this._isSelected);

  String? get pattern_data => _pattern_data;

  set pattern_data(String? value) {
    _pattern_data = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}

List<PatternDetail> getPattern() {
  List<PatternDetail> _list=[];
  _list.add( PatternDetail(null, true));
  for (int i = 0; i < 13; i++) {
    PatternDetail _patternData =
        PatternDetail("assets/images/patterns/p${i}.svg", false);
    _list.add(_patternData);
  }

  return _list;
}
final List<PatternDetail> customPatternList=getPattern();