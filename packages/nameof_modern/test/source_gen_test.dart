import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';
import 'package:nameof_modern/src/nameof_modern_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader =
      await initializeLibraryReaderForDirectory('test', 'source_gen_src.dart');

  initializeBuildLogTracking();

  testAnnotatedElements<Nameof>(reader, NameofModernGenerator({}));
}
