/// Library
library nameof_annotation_modern;

/// Annotation for generate names for code entities
/// Tag class or mixin with this annotation
class Nameof {
  /// This setting response for including and excluding elements of class
  final Coverage? coverage;

  const Nameof({this.coverage});
}

///  Annotation for ignore inner elements of class (or mixin)
class NameofIgnore {
  const NameofIgnore();
}

///  Annotation for tagging inner elements of class (or mixin)
class NameofKey {
  /// Set this for override name of element
  final String? name;

  const NameofKey({this.name});
}

/// Default instance of [Nameof] annotation
const nameof = Nameof();

/// Default instance of [NameofKey] annotation
const nameofKey = NameofKey();

/// Default instance of [NameofIgnore] annotation
const nameofIgnore = NameofIgnore();

/// Rule for including inner elements
enum NameofScope {
  /// Include only public members (fields, methods, etc..)
  onlyPublic,

  /// Include public and private elements
  all
}

/// Behaviour for generating nameof code
enum Coverage {
  /// Include all elements, even not marked with annotation [NameofKey]
  includeImplicit,

  /// Include elements only tagged with annotation [NameofKey]
  excludeImplicit
}
