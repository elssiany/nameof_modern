import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';

part 'models.nameof.dart';

@nameof
class BaseClass {
  final double price;

  BaseClass(this.price);
}

@nameof
class ModelOne extends BaseClass with MixinOne {
  final String name;
  final int id;

  String _behindProp = '';

  String get behindProp => id == 0 ? _behindProp : '';

  set behindProp(String val) {
    _behindProp = val;
  }

  ModelOne(this.name, this.id, double price) : super(price);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}

@Nameof(coverage: Coverage.excludeImplicit)
mixin class MixinOne {
  final int vinilNumber = 124;

  @NameofKey(name: 'hameleon')
  String get nameVinage => 'Hairs';
}

@nameof
class Movie {
  String title;
  String description;

  @nameofIgnore
  int year;

  Movie({
    required this.title,
    required this.description,
    required this.year,
  });
}
