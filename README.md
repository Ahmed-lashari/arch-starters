# Architecture Starters

A CLI tool to bootstrap Flutter projects with pre-configured architecture patterns. Get started quickly with best practices and clean code structure.

## 🚀 Features

- **Dynamic Architecture Discovery**: Automatically syncs with [GitHub](https://github.com/Ahmed-lashari/Architecture-Starters) repository.
- **Multiple Architectures**: MVVM, Clean, and any future architectures added to the repo
- **Smart Caching**: Downloads once, uses cached templates for speed
- **Auto-Updates**: Always gets the latest architectures from GitHub
- **Quick Setup**: Extract complete project structure in seconds
- **Best Practices**: Pre-configured with recommended patterns

## 📦 Installation

Add to your Flutter project's `pubspec.yaml`:

```yaml
dev_dependencies:
  arch_starters: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🎯 Usage

### List Available Architectures

```bash
dart run arch_starters list
```

Output:
```shell
Available architectures:
  * clean
  * mvvm
  * others (if any)
```

### Extract MVVM Architecture

```shell
dart run arch_starters --mvvm
```

### Extract Clean Architecture

```bash
dart run arch_starters --clean
```

### Get Help

```bash
dart run arch_starters --help
```

## ⚠️ Important Warning

**This tool will OVERWRITE your `lib/` folder and `pubspec.yaml` file!**

- ✅ Use this for **NEWLY Created** Flutter projects only
- ✅ Designed for rapid development setup
- ❌ Do NOT use on existing projects with code
- 💾 Your original `pubspec.yaml` is backed up to `pubspec.yaml.backup`

## 📖 What Gets Installed

### MVVM Architecture
- Complete folder structure
- ViewModels with state management
- Repository pattern
- Service layer
- Model classes
- Example views

### Clean Architecture
- Domain layer (entities, use cases)
- Data layer (repositories, data sources)
- Presentation layer (UI, state management)
- Dependency injection setup
- Example implementations

## 🛠️ Example Workflow

```shell
# 1. Create a new Flutter project
flutter create my_app
cd my_app

# 2. Add arch_starters to dev_dependencies
flutter pub add dev:arch_starters

# 3. Extract your preferred architecture
dart run arch_starters --mvvm

# 4. Get dependencies
flutter pub get

# 5. Start coding!
```

## 📝 Requirements

- Flutter SDK
- Dart SDK ^3.0.0
- Internet connection (for first-time download)

## 🐛 Troubleshooting

**Error: Not a Flutter project**
- Make sure you're in the root directory of a Flutter project
- Check that `pubspec.yaml` exists

**Error: Failed to download**
- Check your internet connection
- Verify the [GitHub](https://github.com/Ahmed-lashari/Architecture-Starters) repository is public and accessible.

**Error: Permission denied**
- Run with appropriate permissions
- Check folder write access

## 🤝 Contributing

Contributions are welcome! Please check the [repository](https://github.com/Ahmed-lashari/Architecture-Starters) and [package](https://github.com/Ahmed-lashari/arch-starters) for guidelines.

## 📄 License

This project is licensed under the MIT License.

## 🔗 Links

- [GitHub Architectures](https://github.com/Ahmed-lashari/Architecture-Starters)
- [Package Repository](https://github.com/Ahmed-lashari/arch-starters)
- [Report Issues](https://github.com/Ahmed-lashari/arch-starters/issues)
- [Package Link](https://pub.dev/packages/arch_starters)


## 👨‍💻 Author

Muhammad Ahmed Lashari

---

⭐ If you find this package helpful, please give it a star on [GitHub](https://github.com/Ahmed-lashari/Architecture-Starters)& [Package](https://pub.dev/packages/arch_starters)!