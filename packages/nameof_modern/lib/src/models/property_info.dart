import 'element_info.dart';

class PropertyInfo extends ElementInfo {
  final bool isSetter;
  final bool isGetter;

  PropertyInfo({
    required super.name,
    required super.originalName,
    required super.isPrivate,
    required super.isAnnotated,
    required super.isIgnore,
    required this.isSetter,
    required this.isGetter,
  }) : assert(isGetter ^ isSetter);

  factory PropertyInfo.fromElementInfo(ElementInfo based,
      {required bool isGetter, required bool isSetter}) {
    return PropertyInfo(
        name: based.name,
        originalName: based.originalName,
        isIgnore: based.isIgnore,
        isPrivate: based.isPrivate,
        isAnnotated: based.isAnnotated,
        isGetter: isGetter,
        isSetter: isSetter);
  }

  String get propertyPrefix => isSetter ? 'Set' : 'Get';
}
