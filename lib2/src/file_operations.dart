import 'dart:io';
import 'package:path/path.dart' as path;

class FileOperations {
  Future<void> copyTemplate(Directory sourceDir, String type) async {
    final currentDir = Directory.current;

    /// Verify we're in a Flutter project
    if (!File('${currentDir.path}/pubspec.yaml').existsSync()) {
      throw Exception(
        'Not a Flutter project! Please run this command from your Flutter project root.',
      );
    }

    /// Copy lib/ directory
    final sourceLib = Directory(path.join(sourceDir.path, 'lib'));
    final targetLib = Directory(path.join(currentDir.path, 'lib'));

    if (sourceLib.existsSync()) {
      if (targetLib.existsSync()) {
        targetLib.deleteSync(recursive: true);
      }
      await _copyDirectory(sourceLib, targetLib);
    }

    /// Handle pubspec.yaml
    final sourcePubspec = File(path.join(sourceDir.path, 'pubspec.yaml'));
    final targetPubspec = File(path.join(currentDir.path, 'pubspec.yaml'));

    if (sourcePubspec.existsSync()) {
      /// Backup existing pubspec
      if (targetPubspec.existsSync()) {
        final backup = File(path.join(currentDir.path, 'pubspec.yaml.backup'));
        targetPubspec.copySync(backup.path);
        print('📄 Original pubspec.yaml backed up to pubspec.yaml.backup');
      }

      /// Copy new pubspec
      sourcePubspec.copySync(targetPubspec.path);
    }
  }

  Future<void> _copyDirectory(Directory source, Directory target) async {
    if (!target.existsSync()) {
      target.createSync(recursive: true);
    }

    await for (final entity in source.list(recursive: true)) {
      if (entity is File) {
        final relativePath = path.relative(entity.path, from: source.path);
        final targetPath = path.join(target.path, relativePath);
        final targetFile = File(targetPath);

        targetFile.parent.createSync(recursive: true);
        await entity.copy(targetFile.path);
      }
    }
  }
}
