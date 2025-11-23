import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

class RepoManager {
  static const String repoUrl =
      'https://github.com/Ahmed-lashari/Architecture-Starters/archive/refs/heads/main.zip';
  static const String repoPrefix = 'Architecture-Starters-main';

  late final Directory _cacheDir;
  List<String>? _cachedArchitectures;

  RepoManager() {
    /// Create cache directory in system temp
    final tempBase = Directory.systemTemp;
    _cacheDir = Directory(path.join(tempBase.path, 'arch_starters_cache'));
  }

  /// Get list of available architectures from repo
  Future<List<String>> getAvailableArchitectures({
    bool forceRefresh = false,
  }) async {
    /// Return cached list if available and not forcing refresh
    if (_cachedArchitectures != null && !forceRefresh) {
      return _cachedArchitectures!;
    }

    /// Check if cache exists and is valid
    if (!forceRefresh && _cacheDir.existsSync()) {
      try {
        final architectures = _scanCachedArchitectures();
        if (architectures.isNotEmpty) {
          _cachedArchitectures = architectures;
          return architectures;
        }
      } catch (e) {
        /// Cache invalid, will download fresh
      }
    }

    /// Download fresh repo
    await _downloadAndCacheRepo();

    final architectures = _scanCachedArchitectures();
    _cachedArchitectures = architectures;
    return architectures;
  }

  /// Download and cache the repository
  Future<void> _downloadAndCacheRepo() async {
    // Clean old cache
    if (_cacheDir.existsSync()) {
      _cacheDir.deleteSync(recursive: true);
    }
    _cacheDir.createSync(recursive: true);

    /// Download ZIP
    final response = await http.get(Uri.parse(repoUrl));
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to download repository. HTTP ${response.statusCode}',
      );
    }

    /// Extract ZIP
    final archive = ZipDecoder().decodeBytes(response.bodyBytes);

    for (final file in archive) {
      if (file.isFile && file.name.startsWith('$repoPrefix/')) {
        final relativePath = file.name.substring(repoPrefix.length + 1);

        /// Skip README.md in root
        if (relativePath == 'README.md') continue;

        final filePath = path.join(_cacheDir.path, relativePath);
        final outFile = File(filePath);
        outFile.createSync(recursive: true);
        outFile.writeAsBytesSync(file.content as List<int>);
      }
    }
  }

  /// Scan cached directory for architectures
  List<String> _scanCachedArchitectures() {
    if (!_cacheDir.existsSync()) {
      return [];
    }

    final architectures = <String>[];

    for (final entity in _cacheDir.listSync()) {
      if (entity is Directory) {
        final dirName = path.basename(entity.path);

        /// Check if it has lib/ and pubspec.yaml (valid architecture)
        final libDir = Directory(path.join(entity.path, 'lib'));
        final pubspecFile = File(path.join(entity.path, 'pubspec.yaml'));

        if (libDir.existsSync() && pubspecFile.existsSync()) {
          architectures.add(dirName);
        }
      }
    }

    architectures.sort(); // Sort alphabetically
    return architectures;
  }

  /// Get cached directory for a specific architecture
  Directory? getArchitectureDir(String architecture) {
    final archDir = Directory(path.join(_cacheDir.path, architecture));
    return archDir.existsSync() ? archDir : null;
  }

  /// Check if architecture exists in cache
  bool hasArchitecture(String architecture) {
    return getArchitectureDir(architecture) != null;
  }

  /// Force refresh the cache
  Future<void> refreshCache() async {
    await getAvailableArchitectures(forceRefresh: true);
  }

  /// Clear all cache
  void clearCache() {
    if (_cacheDir.existsSync()) {
      _cacheDir.deleteSync(recursive: true);
    }
    _cachedArchitectures = null;
  }
}
