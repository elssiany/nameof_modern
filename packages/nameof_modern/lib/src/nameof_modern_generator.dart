import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';
import 'package:nameof_modern/src/commons/enum_extensions.dart';
import 'package:source_gen/source_gen.dart';

import 'models/options.dart';
import 'nameof_modern_code_processor.dart';
import 'nameof_modern_visitor.dart';

class NameofModernGenerator extends GeneratorForAnnotation<Nameof> {
  final Map<String, dynamic> config;

  NameofModernGenerator(this.config);

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print("element.kind: ${element.kind}");
    print("ElementKind.CLASS: ${ElementKind.CLASS}");
    if (element.kind != ElementKind.CLASS) {
      throw UnsupportedError("This is not a class!");
    }

    final options = _parseConfig(annotation);

    final visitor = NameofModernVisitor(element.name ??
        () {
          throw UnsupportedError(
              'Class or mixin element does not have a name!');
        }());
    element.visitChildren(visitor);

    final code = NameofModernCodeProcessor(options, visitor).process();

    return code;
  }

  NameofOptions _parseConfig(ConstantReader annotation) {
    final coverageConfigString = config['coverage']?.toString();

    bool covTest(Coverage coverage) =>
        coverageConfigString == coverage.toShortString();

    final coverageConfig = Coverage.values.any(covTest)
        ? Coverage.values.firstWhere(covTest)
        : null;

    final coverageAnnotation = enumValueForDartObject(
      annotation.read('coverage'),
      Coverage.values,
    );

    return NameofOptions(
        coverage:
            coverageAnnotation ?? coverageConfig ?? Coverage.includeImplicit,
        scope: NameofScope.onlyPublic);
  }

  T? enumValueForDartObject<T>(
    ConstantReader reader,
    List<T> items,
  ) {
    return reader.isNull
        ? null
        : items[reader.objectValue.getField('index')!.toIntValue()!];
  }
}
