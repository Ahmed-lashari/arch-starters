import 'dart:io';
import 'package:ansi_styles/ansi_styles.dart';
import 'repo_manager.dart';
import 'file_operations.dart';

class CommandHandler {
  final RepoManager _repoManager = RepoManager();

  /// List all available architectures from GitHub repo
  Future<void> listArchitectures() async {
    try {
      print(AnsiStyles.blue('🔍 Fetching available architectures...'));
      print('');

      final architectures = await _repoManager.getAvailableArchitectures();

      if (architectures.isEmpty) {
        print(AnsiStyles.yellow('⚠️  No architectures found in repository.'));
        return;
      }

      print(AnsiStyles.bold(AnsiStyles.cyan('Available architectures:')));
      for (final arch in architectures) {
        print(AnsiStyles.green('  ✓ $arch'));
      }
    } catch (e) {
      print(AnsiStyles.red('❌ Failed to fetch architectures: $e'));
      print(AnsiStyles.yellow('Please check your internet connection.'));
    }
  }

  /// Extract a specific architecture
  Future<void> extractArchitecture(String type) async {
    try {
      /// Fetch available architectures first
      print(AnsiStyles.blue('🔍 Checking available architectures...'));
      final architectures = await _repoManager.getAvailableArchitectures();

      // Validate architecture exists
      if (!architectures.contains(type)) {
        print('');
        print(AnsiStyles.red('❌ Architecture "$type" not found!'));
        print('');
        print(AnsiStyles.yellow('Available architectures:'));
        for (final arch in architectures) {
          print(AnsiStyles.white('  • $arch'));
        }
        print('');
        print(
          AnsiStyles.cyan(
            'Use: ${AnsiStyles.bold('dart run arch_starters list')} to see all options',
          ),
        );
        exit(1);
      }

      print('');

      /// Show warning with prominent styling
      print(AnsiStyles.bold(AnsiStyles.yellow('⚠️  WARNING:')));
      print(
        AnsiStyles.yellow(
          'Your current lib/ and pubspec.yaml files will be overwritten.',
        ),
      );
      print(
        AnsiStyles.red(
          'This package is only recommended for NEWLY CREATED Flutter projects.',
        ),
      );
      print(
        AnsiStyles.cyan('It is designed for rapid and fast development setup.'),
      );
      print('');
      stdout.write(AnsiStyles.bold('Do you want to proceed? (y/N): '));

      final input = stdin.readLineSync()?.trim().toLowerCase();

      if (input != 'y') {
        print(AnsiStyles.red('❌ Operation cancelled.'));
        return;
      }

      print('');
      print(
        AnsiStyles.blue(
          '📦 Extracting ${AnsiStyles.bold(type)} architecture...',
        ),
      );

      /// Get architecture directory from cache
      final archDir = _repoManager.getArchitectureDir(type);
      if (archDir == null) {
        throw Exception('Architecture directory not found in cache');
      }

      /// Copy files
      final fileOps = FileOperations();
      await fileOps.copyTemplate(archDir, type);

      print('');
      print(
        AnsiStyles.bold(
          AnsiStyles.green('✅ $type architecture extracted successfully!'),
        ),
      );
      print('');
      print(AnsiStyles.bold(AnsiStyles.cyan('Next steps:')));
      print(
        AnsiStyles.white('  1. Run: ${AnsiStyles.yellow('flutter pub get')}'),
      );
      print(AnsiStyles.white('  2. Review the generated code structure'));
      print(AnsiStyles.white('  3. Start building your app! 🚀'));
    } catch (e) {
      print('');
      print(AnsiStyles.bold(AnsiStyles.red('❌ Error: $e')));
      print('');
      print(AnsiStyles.yellow('Please check:'));
      print(AnsiStyles.white('  • Your internet connection'));
      print(AnsiStyles.white('  • You are in a Flutter project directory'));
      print(AnsiStyles.white('  • You have write permissions'));
      exit(1);
    }
  }

  /// Show help with dynamic architecture list
  Future<void> showHelp() async {
    print(
      AnsiStyles.bold(
        AnsiStyles.cyan(
          '🏗️  Architecture Starters - Bootstrap Flutter projects',
        ),
      ),
    );
    print('');

    try {
      /// Fetch architectures for dynamic help
      final architectures = await _repoManager.getAvailableArchitectures();

      print(AnsiStyles.bold('Usage:'));

      if (architectures.isNotEmpty) {
        for (final arch in architectures) {
          final spaces = ' ' * (10 - arch.length);
          print(
            '  ${AnsiStyles.green('dart run arch_starters --$arch')}$spaces Extract $arch architecture',
          );
        }
      }

      print(
        '  ${AnsiStyles.green('dart run arch_starters list')}       List available architectures',
      );
      print(
        '  ${AnsiStyles.green('dart run arch_starters --help')}     Show this help message',
      );
      print(
        '  ${AnsiStyles.green('dart run arch_starters --version')}  Show version',
      );
    } catch (e) {
      /// Fallback if can't fetch architectures
      print(AnsiStyles.bold('Usage:'));
      print('  ${AnsiStyles.green('dart run arch_starters --<architecture>')}');
      print('  ${AnsiStyles.green('dart run arch_starters list')}');
      print('  ${AnsiStyles.green('dart run arch_starters --help')}');
      print('  ${AnsiStyles.green('dart run arch_starters --version')}');
    }

    print('');
    print(AnsiStyles.bold(AnsiStyles.yellow('⚠️  WARNING:')));
    print(
      AnsiStyles.yellow(
        '    This tool will overwrite your lib/ and pubspec.yaml files.',
      ),
    );
    print(AnsiStyles.red('    Only use this for NEW Flutter projects!'));
  }

  /// Clear cache
  void clearCache() {
    _repoManager.clearCache();
    print(AnsiStyles.green('✅ Cache cleared successfully!'));
  }
}
