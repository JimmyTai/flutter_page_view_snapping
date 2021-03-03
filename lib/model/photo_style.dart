class PhotoStyle {
  static const PhotoStyle solid = PhotoStyle._inner('solid', 'SOLID');
  static const PhotoStyle classic = PhotoStyle._inner('classic', 'CLASSIC');
  static const List<PhotoStyle> values = [solid, classic];

  final String type;
  final String name;
  const PhotoStyle._inner(this.type, this.name);
}
