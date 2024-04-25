import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

TypeChecker _typeChecker(final Type type) => TypeChecker.fromRuntime(type);

extension AnnotationChecker on Element {
  bool hasAnnotation(final Type type) {
    return _typeChecker(type).hasAnnotationOfExact(this);
  }

  DartObject? getAnnotation(final Type type) {
    return _typeChecker(type).firstAnnotationOfExact(this);
  }
}
