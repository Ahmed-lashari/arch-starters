void main() {
  print('''
Example Usage of arch_starters CLI:

1️⃣ Add this package to dev_dependencies in pubspec.yaml file:

dev_dependencies:
  arch_starters: ^1.0.1

2️⃣ Then run one of the following commands:

To apply MVVM template:
    dart run arch_starters --mvvm

To apply Clean Architecture:
    dart run arch_starters --clean

To list available templates:
    dart run arch_starters list

⚠️ Warning:
Running mvvm or clean will overwrite:
  - lib/
  - pubspec.yaml
So use it on a NEWLY created Flutter projects for rapid setup & best practices.
''');
}
