import 'package:test/test.dart';

import 'implementation/models.dart';

void main() {
  group('A group of tests for check generation code', () {
    test('test generate code for model one', () {
      expect(NameofModelOne.className, 'ModelOne');
      expect(NameofModelOne.constructor, '');
      expect(NameofModelOne.fieldName, 'name');
      expect(NameofModelOne.fieldId, 'id');
      expect(NameofModelOne.functionBuildValue, 'buildValue');
    });

    test('test generate code for base class', () {
      expect(NameofBaseClass.className, 'BaseClass');
      expect(NameofBaseClass.fieldPrice, 'price');
      expect(NameofBaseClass.constructor, '');
    });

    test('test generate code for mixin', () {
      expect(NameofMixinOne.propertyGetNameVinage, 'hameleon');
      expect(NameofMixinOne.className, 'MixinOne');
    });
  });
}
