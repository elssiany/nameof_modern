import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';
import 'package:nameof_modern/src/commons/string_extensions.dart';

import 'models/element_info.dart';
import 'models/options.dart';
import 'models/property_info.dart';
import 'nameof_modern_visitor.dart';

/// Code lines builder
class NameofModernCodeProcessor {
  /// Build options
  final NameofOptions options;

  /// Code info
  final NameofModernVisitor visitor;

  NameofModernCodeProcessor(this.options, this.visitor);

  String process() {
    return _generateNames(visitor);
  }

  String _generateNames(NameofModernVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = 'Nameof${visitor.className}';

    buffer.writeln(
        '/// Container for names of elements belonging to the [${visitor.className}] class');
    buffer.writeln('abstract class $classContainerName {');

    final className =
        'static const String className = \'${visitor.className}\';';

    final constructorNames =
        _getCodeParts('constructor', visitor.constructors.values);

    final fieldNames = _getCodeParts('field', visitor.fields.values);

    final functionNames = _getCodeParts('function', visitor.functions.values);

    final propertyNames = _getFilteredNames(visitor.properties.values).map((prop) =>
        'static const String property${(prop as PropertyInfo).propertyPrefix}${prop.originalName.capitalize().privatize()} = \'${prop.name}\';');

    void writeCode(Iterable<String> codeLines) {
      if (codeLines.isNotEmpty) {
        buffer.writeln();
        buffer.writeln(join(codeLines));
      }
    }

    buffer.writeln(className);

    for (var codeLines in [
      constructorNames,
      fieldNames,
      propertyNames,
      functionNames
    ]) {
      writeCode(codeLines);
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  Iterable<ElementInfo> _getFilteredNames(Iterable<ElementInfo> infos) {
    Iterable<ElementInfo> result = (options.coverage == Coverage.includeImplicit
            ? infos.map((e) => e)
            : infos.where((element) => element.isAnnotated).map((e) => e))
        .where((element) => !element.isIgnore);

    return options.scope == NameofScope.onlyPublic
        ? result.where((element) => !element.isPrivate)
        : result;
  }

  Iterable<String> _getCodeParts(
      String elementType, Iterable<ElementInfo> elements) {
    return _getFilteredNames(elements).map((element) =>
        'static const String $elementType${element.scopePrefix}${element.originalName.capitalize().privatize()} = \'${element.name}\';');
  }
}
