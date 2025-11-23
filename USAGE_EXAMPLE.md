# Usage Examples

## How the Dynamic System Works

### Scenario 1: Initial Usage

```bash
$ dart run arch_starters list
🔍 Fetching available architectures...

Available architectures:
  ✓ clean
  ✓ mvvm
```

The package downloaded your repo and discovered 2 architectures.

### Scenario 2: You Add MVC to GitHub

You push a new `mvc/` folder to your GitHub repo:

```
Architecture-Starters/
├── clean/
├── mvvm/
└── mvc/          ← NEW!
    ├── lib/
    └── pubspec.yaml
```

User runs the command again:

```bash
$ dart run arch_starters list
🔍 Fetching available architectures...

Available architectures:
  ✓ clean
  ✓ mvc           ← Automatically discovered!
  ✓ mvvm
```

### Scenario 3: Using MVC Architecture

```bash
$ dart run arch_starters --mvc
🔍 Checking available architectures...

⚠️  WARNING:
Your current lib/ and pubspec.yaml files will be overwritten.
This package is only recommended for NEWLY CREATED Flutter projects.
It is designed for rapid and fast development setup.

Do you want to proceed? (y/N): y

📦 Extracting mvc architecture...
📄 Original pubspec.yaml backed up to pubspec.yaml.backup

✅ mvc architecture extracted successfully!

Next steps:
  1. Run: flutter pub get
  2. Review the generated code structure
  3. Start building your app! 🚀
```

### Scenario 4: Invalid Architecture

```bash
$ dart run arch_starters --bloc
🔍 Checking available architectures...

❌ Architecture "bloc" not found!

Available architectures:
  • clean
  • mvc
  • mvvm

Use: dart run arch_starters list to see all options
```

### Scenario 5: Cache Management

```bash
# First run - downloads repo
$ dart run arch_starters list
🔍 Fetching available architectures...
Available architectures:
  ✓ clean
  ✓ mvvm

# Second run - uses cache (instant)
$ dart run arch_starters list
🔍 Fetching available architectures...
Available architectures:
  ✓ clean
  ✓ mvvm

# Clear cache and refresh
$ dart run arch_starters --clear-cache
✅ Cache cleared successfully!

$ dart run arch_starters list
🔍 Fetching available architectures...    ← Downloads again
Available architectures:
  ✓ clean
  ✓ mvc    ← New architecture appears!
  ✓ mvvm
```

## Dynamic Help Command

```bash
$ dart run arch_starters --help
🏗️  Architecture Starters - Bootstrap Flutter projects

Usage:
  dart run arch_starters --clean      Extract clean architecture
  dart run arch_starters --mvc        Extract mvc architecture
  dart run arch_starters --mvvm       Extract mvvm architecture
  dart run arch_starters list         List available architectures
  dart run arch_starters --help       Show this help message
  dart run arch_starters --version    Show version

⚠️  WARNING:
    This tool will overwrite your lib/ and pubspec.yaml files.
    Only use this for NEW Flutter projects!
```

Notice how the help automatically updates with all available architectures!

## Complete Workflow Example

```bash
# 1. Create new Flutter project
flutter create my_awesome_app
cd my_awesome_app

# 2. Add arch_starters
flutter pub add dev:arch_starters

# 3. See what's available
dart run arch_starters list

# 4. Choose and extract architecture
dart run arch_starters --clean

# 5. Get dependencies
flutter pub get

# 6. Start coding!
flutter run
```

## Error Handling Examples

### Not in Flutter Project

```bash
$ dart run arch_starters --mvvm
🔍 Checking available architectures...
📦 Extracting mvvm architecture...

❌ Error: Not a Flutter project! Please run this command from your Flutter project root.

Please check:
  • Your internet connection
  • You are in a Flutter project directory
  • You have write permissions
```

### Network Issues

```bash
$ dart run arch_starters list
🔍 Fetching available architectures...
❌ Failed to fetch architectures: Failed to download repository. HTTP 404
Please check your internet connection.
```

## Benefits of Dynamic Approach

✅ **No Package Updates Needed**: Add architectures to GitHub, users get them instantly
✅ **Always in Sync**: Package automatically reflects your repository structure
✅ **Flexible**: Support unlimited architectures without code changes
✅ **Fast**: Caching makes subsequent operations instant
✅ **Reliable**: Validates architectures exist before extraction