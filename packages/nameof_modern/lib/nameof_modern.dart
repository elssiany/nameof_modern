/// Support for doing something awesome.
///
/// More dartdocs go here.
library nameof_modern;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/nameof_modern_generator.dart';

/// Builds generators for `build_runner` to run
Builder nameof(BuilderOptions options) {
  return PartBuilder(
    [NameofModernGenerator(options.config)],
    '.nameof.dart',
    options: options,
  );
}
