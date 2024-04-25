<p align="center">
<a href="https://github.com/elssiany/nameof_modern"><img src="https://img.shields.io/github/stars/elssiany/nameof_modern.svg?style=flat&logo=github&colorB=green&label=stars" alt="Star on Github"></a>
<a href="https://pub.dev/packages/nameof_annotation_modern/score"><img src="https://img.shields.io/pub/points/nameof_modern.svg" alt="Pub Points"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License: MIT"></a>
</p>

---

# Nameof Modern

In some cases, there are projects that need to access entity names for different cases in programming, such as methods, properties, constructors, etc. Unfortunately, today _Flutter_ does not have a reflection mechanism designed for this purpose. _But there is code generation!_ This package uses code generation to help access the
property names of a class, method, etc. This package is an update of the original **package:** [nameof](https://pub.dev/packages/nameof). **Nameof Modern** is one hundred percent nameof code. Credits go to the creators of [nameof](https://pub.dev/packages/nameof) ❤️. Nameof Modern is updated and has all the latest updates for the proper functioning of the new 2024 and future projects. This package is new and with the help of the community we are improving it ❤️.

🗒️`Important: `This package is created based on the package [nameof](https://pub.dev/packages/nameof). [nameof](https://pub.dev/packages/nameof) is a name generator for _Dart_ class members, such as fields, properties, methods, and constructors. `nameof_modern` is one hundred percent [nameof](https://pub.dev/packages/nameof) code, credits to [nameof](https://pub.dev/packages/nameof) author ❤️.

- This is the official documentation guide for [nameof](https://pub.dev/packages/nameof). For more source information, please visit the official page of [nameof](https://pub.dev/packages/nameof)

#### This guide is based on the official [nameof](https://pub.dev/packages/nameof) documentation and has been updated for the modern version of `nameof_modern`.


# Menu

- [Menu](#menu)
- [How to use](#how-to-use)

    - [Install](#install)

    - [Run the generator](#run-the-generator)
    - [Using Nameof Modern](#using-nameof)
        - [Simple usage](#simple-usage)
        - [Models coverage](#models-coverage)
        - [Override names](#override-names)
        - [NameofKey targets](#nameofkey-targets)

    - [Configurations](#configurations)
        - [Changing the behavior for a specific model](#changing-the-behavior-for-a-specific-model)
        - [Changing the behavior for the entire project](#changing-the-behavior-for-the-entire-project)

# How to use

## Install
To use `Nameof Modern`, you will need your typical [build_runner](https://pub.dev/packages/build_runner) code-generator setup.\
First, install [build_runner](https://pub.dev/packages/build_runner) and `Nameof Modern` by adding them to your `pubspec.yaml` file:

If you are using creating a Flutter project:

```console
$ flutter pub add nameof_annotation_modern
$ flutter pub add --dev build_runner
$ flutter pub add --dev nameof_modern
```

If you are using creating a Dart project:

```console
$ dart pub add nameof_annotation_modern
$ dart pub add --dev build_runner
$ dart pub add --dev nameof_modern
```

This installs three packages:

- [build_runner](https://pub.dev/packages/build_runner), the tool to run code-generators
- [nameof_modern](https://pub.dev/packages/nameof_modern), the code generator
- [nameof_annotation](https://pub.dev/packages/nameof_annotation), a package containing annotations for `Nameof Modern`.

## Run the generator

To run the code generator, execute the following command:

```
dart run build_runner build
```

For Flutter projects, you can also run:

```
flutter pub run build_runner build
```

Note that like most code-generators, [nameof_modern](https://pub.dev/packages/nameof_modern) will need you to both import the annotation ([nameof_annotation_modern](https://pub.dev/packages/nameof_annotation_modern))
and use the `part` keyword on the top of your files.

As such, a file that wants to use [nameof_modern](https://pub.dev/packages/nameof_modern) will start with:

```dart
import 'package:nameof_annotation_modern/nameof_annotation_modern.dart';

part 'my_file.nameof.dart';

```

## Using Nameof

### Simple usage

For example we have a class `Movie`. For names generation of this class you need to tell generator some instructions with `nameof modern` annotation:

```dart
@nameof
class Movie {
  final String title;
  final String description;
  final int year;
  final String coverUrl;

  Movie(this.title, this.description, this.year, this.coverUrl);
}
```

Then you need to run generator [Run the generator](#run-the-generator)

It will generate next code:

```dart
/// Container for names of elements belonging to the [Movie] class
abstract class NameofMovie {
  static const String className = 'Movie';

  static const String constructor = '';

  static const String fieldTitle = 'title';
  static const String fieldDescription = 'description';
  static const String fieldYear = 'year';
  static const String fieldCoverUrl = 'coverUrl';
}
```

Then use it in your code:
```dart
print(NameofMovie.fieldTitle);
print(NameofMovie.fieldDescription);
print(NameofMovie.fieldYear);
print(NameofMovie.fieldCoverUrl);
```

It is simple!

Also you may to use `nameof` annotation for abstract *classes* and *mixins*.

### Models coverage

You can have very precision setting of coverage of model's members with use coverage settings and `@NameofIgnore` annotation. For example two next configurations will lead to one output.
- First configuration:
```dart
@Nameof(coverage: Coverage.excludeImplicit)
class Movie {
  final String title;
  final String description;
  @nameofKey
  final int year;
  @nameofKey
  final String coverUrl;

  Movie(this.title, this.description, this.year, this.coverUrl);
}
```

- Second configuration:
```dart
@Nameof(coverage: Coverage.includeImplicit)
class Movie {
  @nameofIgnore
  final String title;
  @nameofIgnore
  final String description;

  final int year;

  final String coverUrl;
  
  @nameofIgnore
  Movie(this.title, this.description, this.year, this.coverUrl);
}
```

Output:

```dart
/// Container for names of elements belonging to the [Movie] class
abstract class NameofMovie {
  static const String className = 'Movie';

  static const String fieldYear = 'year';
  static const String fieldCoverUrl = 'coverUrl';
}
```

Take an attention for `coverage` setting, `@nameofKey` and `@nameofIgnore` annotations.
If you do not set coverage, generator will use  `includeImplicit` setting by default.

### Override names
If you want override name of element you can do it!
Code:

```dart
@nameof
class Ephemeral {
  @NameofKey(name: 'AbRaCadabra')
  String get flushLight => 'Purple';
}
```

Generator output:
```dart
/// Container for names of elements belonging to the [Ephemeral] class
abstract class NameofEphemeral {
  static const String className = 'Ephemeral';

  static const String constructor = '';

  static const String propertyGetFlushLight = 'AbRaCadabra';
}
```

As can you see property was renamed. Output has `AbRaCadabra` not `flushLight`.

### NameofKey targets

`@NameofKey` annotatition applyed for public fields, methods, properties and constructors.

## Configurations

Nameof offers various options to customize the generated code. For example, you
may want to change coverage behaviour of model.

To do so, there are two possibilities:

### Changing the behavior for a specific model

If you want to customize the generated code for only one specific class,
you can do so by using annotation setting:

```dart
@Nameof(coverage: Coverage.excludeImplicit)
class Empoyee {...}
```

### Changing the behavior for the entire project

Instead of applying your modification to a single class, you may want to apply it to
all Nameof models at the same time.

You can do so by customizing a file called `build.yaml`  
This file is an optional configuration file that should be placed next to your `pubspec.yaml`:

```
project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

There, you will be able to change the same options as the options found in `@Nameof` (see above)
by writing:

```yaml
targets:
  $default:
    builders:
      nameof:
        options:
          coverage: includeImplicit
          
```

Two settings for coverage is available: `includeImplicit` (default) and `excludeImplicit`


## Contributing

Contributions are welcome!

Here is a curated list of how you can help:

- Report bugs and scenarios that are difficult to implement
- Report parts of the documentation that are unclear
- Fix typos/grammar mistakes
- Update the documentation or add examples
- Implement new features by making a pull-request