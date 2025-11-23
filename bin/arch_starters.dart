import 'dart:io';
import 'package:arch_starters/arch_starters.dart';
import 'package:args/args.dart';
import 'package:ansi_styles/ansi_styles.dart';

void main(List<String> arguments) async {
  final commandHandler = CommandHandler();

  /// Handle special commands without parsing flags
  if (arguments.isEmpty ||
      arguments.contains('--help') ||
      arguments.contains('-h')) {
    await commandHandler.showHelp();
    return;
  }

  if (arguments.contains('--version') || arguments.contains('-v')) {
    print(AnsiStyles.cyan('arch_starters version ${AnsiStyles.bold('1.0.1')}'));
    return;
  }

  if (arguments.contains('list')) {
    await commandHandler.listArchitectures();
    return;
  }

  if (arguments.contains('--clear-cache')) {
    commandHandler.clearCache();
    return;
  }

  /// Parse architecture flags dynamically
  try {
    /// Fetch available architectures
    final repoManager = RepoManager();
    final architectures = await repoManager.getAvailableArchitectures();

    /// Build parser dynamically based on available architectures
    final parser = ArgParser();
    for (final arch in architectures) {
      parser.addFlag(
        arch,
        negatable: false,
        help: 'Extract $arch architecture',
      );
    }

    final argResults = parser.parse(arguments);

    /// Check which architecture was requested
    String? requestedArch;
    for (final arch in architectures) {
      if (argResults[arch] == true) {
        requestedArch = arch;
        break;
      }
    }

    if (requestedArch != null) {
      await commandHandler.extractArchitecture(requestedArch);
    } else {
      /// No valid flag found
      print(AnsiStyles.red('❌ Invalid command or architecture.'));
      print('');
      await commandHandler.showHelp();
      exit(1);
    }
  } catch (e) {
    /// If parsing fails or architecture not recognized
    print(AnsiStyles.red('❌ Error: $e'));
    print('');
    print(AnsiStyles.yellow('Available commands:'));
    print('  dart run arch_starters list       List available architectures');
    print('  dart run arch_starters --help     Show help');
    print('  dart run arch_starters --version  Show version');
    exit(1);
  }
}
