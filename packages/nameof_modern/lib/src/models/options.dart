import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';

/// Generator options
class NameofOptions {
  /// Exclude and include rules
  final Coverage coverage;

  /// Scope options (public or all)
  final NameofScope scope;

  NameofOptions({required this.coverage, required this.scope});
}
