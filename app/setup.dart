
import 'dart:io';

void main() {
  // verify execution location
  if (!new Directory('app').existsSync()) {
    print('This script must be run from the project root.');
    exit(1);
  }

  // copy packages
  runProcess('cp', ['-r', 'packages/', 'app/packages/']);

  // build with dart2js
  runProcess(
      'dart2js',
      ['app/demo.dart', '--out=app/demo.dart.js']);

  // clean up some clutter
  runProcess('rm', ['app/demo.dart.js.deps', 'app/demo.dart.js.map']);
}

void runProcess(String executable, List<String> arguments) {
  print("${executable} ${arguments.join(' ')}");

  ProcessResult result = Process.runSync(executable, arguments);

  if (result.stdout != null && !result.stdout.isEmpty) {
    print(result.stdout.trim());
  }

  if (result.stderr != null && !result.stderr.isEmpty) {
    print(result.stderr);
  }

  if (result.exitCode != 0) {
    throw new Exception(
        "${executable} failed with a return code of ${result.exitCode}");
  }
}
