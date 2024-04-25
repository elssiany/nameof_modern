import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';

part 'sample.nameof.dart';

@nameof
mixin class VinilMixin {
  final int vinilColor = 124;
}

@Nameof()
class BaseClass {
  final double price;

  BaseClass(this.price);
}

@nameof
class Car {
  final double price;
  final double weigth;

  final int year;
  final String model;

  int get moto => 0;

  @NameofIgnore()
  set moto(int repr) {}

  Car(this.price, this.weigth, this.year, this.model);

  Car.sedan(double price, double weigth, int year)
      : this(price, weigth, year, 'Sedan');
}

@Nameof(coverage: Coverage.excludeImplicit)
class Sample extends BaseClass with VinilMixin {
  final String name;
  String _behind = '';

  int length;

  factory Sample.mega() {
    return Sample('MEGA', 342, 12);
  }

  final int id;

  @NameofKey(name: '_abracadabra')
  String get getColor => 'red';

  set setColor(String repr) {}

  // ignore: unnecessary_getters_setters
  String get behind => _behind;

  set behind(String val) {
    _behind = val;
  }

  Sample(this.name, this.id, this.length) : super(0);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}

@Nameof(coverage: Coverage.includeImplicit)
class Itinerary {
  @nameofIgnore
  final double longStart;

  @nameofIgnore
  final double latStart;

  @nameofIgnore
  final double longEnd;

  @nameofIgnore
  final double latEnd;

  final String name;
  final double length;

  Itinerary(this.longStart, this.latStart, this.longEnd, this.latEnd, this.name,
      this.length);
}

@nameof
class Ephemeral {
  @NameofKey(name: 'AbRaCadabra')
  String get flushLight => 'Purple';
}
