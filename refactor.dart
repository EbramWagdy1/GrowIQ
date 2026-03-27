import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true, followLinks: false)
                   .whereType<File>()
                   .where((f) => f.path.endsWith('.dart'));
                   
  final regex = RegExp(r'AppStrings\.([a-zA-Z0-9_]+)');
  final ignoreSet = {'fbLink', 'instaLink', 'linkedInLink', 'githubLink', 'websiteLink'};

  for (final file in files) {
    if (file.path.replaceAll('\\', '/').contains('core/utils/app_strings.dart')) continue;
    if (file.path.replaceAll('\\', '/').contains('core/l10n/arb')) continue;

    String content = file.readAsStringSync();
    if (!content.contains('AppStrings.')) continue;
    
    List<String> lines = content.split('\n');
    bool modified = false;
    for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains('AppStrings.')) {
            bool shouldReplaceLine = false;
            lines[i] = lines[i].replaceAllMapped(regex, (match) {
                String val = match.group(1)!;
                if (ignoreSet.contains(val)) {
                    return match.group(0)!; // keep 
                }
                shouldReplaceLine = true;
                return 'AppLocalizations.of(context)!.$val';
            });
            
            if (shouldReplaceLine) {
                // simple const removal for Text widgets that contained AppStrings
                lines[i] = lines[i].replaceAll(RegExp(r'\bconst\s+'), '');
                modified = true;
            }
        }
    }
    
    if (modified) {
        String newContent = lines.join('\n');
        // add import if not present
        if (!newContent.contains("package:growiq/core/l10n/arb/app_localizations.dart")) {
            // Find last import
            int lastImportIndex = newContent.lastIndexOf(RegExp(r"import\s+'[^']+';"));
            if (lastImportIndex != -1) {
                int endOfLine = newContent.indexOf('\n', lastImportIndex);
                newContent = "${newContent.substring(0, endOfLine + 1)}import 'package:growiq/core/l10n/arb/app_localizations.dart';\n${newContent.substring(endOfLine + 1)}";
            } else {
                newContent = "import 'package:growiq/core/l10n/arb/app_localizations.dart';\n$newContent";
            }
        }
        file.writeAsStringSync(newContent);
        stdout.writeln('Updated ${file.path}');
    }
  }
}
