import 'dart:io';

import 'package:path/path.dart' as path;

void main() {
  final scriptDirectory = path.dirname(Platform.script.toFilePath());
  final assetsFolderPath = path.join(scriptDirectory, '..', 'assets');

  final assetsDirectory = Directory(assetsFolderPath);
  if (assetsDirectory.existsSync()) {
    final subDirectories = assetsDirectory.listSync(recursive: false, followLinks: false);
    final enumNames = <String>[];
    final pathCode = StringBuffer('enum KAssetName {\n');
    final subfolderPaths = <String, String>{};
    for (final subDirectory in subDirectories) {
      if (subDirectory is Directory) {
        final directoryName = path.basename(subDirectory.path);
        final files = subDirectory.listSync(recursive: false, followLinks: false);
        for (final file in files) {
          if (file is File) {
            final fileName = path.basename(file.path);
            final assetName = fileName.replaceAll(RegExp(r'\W+'), '');
            if (!enumNames.contains(assetName)) {
              enumNames.add(assetName);
              pathCode.write('  $assetName,\n');
              subfolderPaths[assetName] = directoryName;
            } else {
              print('Naming with $fileName is in two folders which are:');
              print(subDirectories
                  .where((subDir) =>
              subDir is Directory &&
                  subDir.path != subDirectory.path &&
                  subDir.listSync().any((subFile) => subFile is File && path.basename(subFile.path) == fileName))
                  .map((subDir) => subDir.path)
                  .join(' & '));
              print('We generate paths for $fileName using folder from ${subDirectory.path},');
              print('Please remove one file from ${subDirectory.path} or the other folder(s),');
              print('and then run this CLI again.');
              return;
            }
          }
        }
      }
    }
    pathCode.write('}\n\n');
    pathCode.write('extension AssetsExtension on KAssetName {\n');
    pathCode.write('  String get imagePath {\n');
    pathCode.write('    const String _rootPath = \'assets\';\n');
    for (final subfolderPath in subfolderPaths.values.toSet()) {
      pathCode.write('  const String _${subfolderPath}Dir = \'\$_rootPath/$subfolderPath\';\n');
    }
    pathCode.write('    switch (this) {\n');
    for (final assetName in enumNames) {
      pathCode.write('      case KAssetName.$assetName:\n');
      final subfolderPath = subfolderPaths[assetName];
      pathCode.write('        return \'\$_${subfolderPath?.toLowerCase()}Dir/$assetName\';\n');
    }
    pathCode.write('    }\n');
    pathCode.write('    return \'\';\n');
    pathCode.write('  }\n');
    pathCode.write('}\n');

    final kAssetsPath = path.join(scriptDirectory, '..', 'lib', 'utils', 'styles', 'k_assets.dart');
    final kAssetsFile = File(kAssetsPath);
    kAssetsFile.writeAsStringSync(pathCode.toString());

    print('Successfully generated image paths.');
  } else {
    print('Error: Assets folder not found.');
  }
}