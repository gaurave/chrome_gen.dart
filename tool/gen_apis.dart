// Copyright (c) 2013, the gen_tools.dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

library gen_apis;

import 'dart:io';
import 'dart:convert';

import 'gen_api.dart';
import 'translation.dart';
import 'src/src_gen.dart';
import 'src/utils.dart';

void main() {
  DateTime startTime = new DateTime.now();

  new GenApis().generate();

  Duration elapsed = new DateTime.now().difference(startTime);
  print("generated in ${elapsed.inMilliseconds}ms.");
}

class GenApis {
  Directory outDir;
  Directory idlDir;
  File apisFile;
  File overridesFile;

  GenApis() {
    _init();
  }

  void generate() {
    print("reading ${apisFile.path}...");

    var apisInfo = JSON.decode(apisFile.readAsStringSync());

    _generateApi('app', apisInfo['packaged_app']);
    _generateApi('ext', apisInfo['extension'], apisInfo['packaged_app']);
  }

  void _init() {
    print(Directory.current);

    outDir = new Directory('lib');
    apisFile = new File('meta/apis.json');
    overridesFile = new File('meta/overrides.json');
    idlDir = new Directory('idl');

    if (!idlDir.existsSync()) {
      throw new Exception('${idlDir.path} not found');
    }
  }

  void _generateApi(String name, List<String> libraryNames, [List<String> alreadyWritten]) {
    File libFile = new File("${outDir.path}/chrome_${name}.dart");

    DartGenerator generator = new DartGenerator();

    generator.writeln(LICENSE);
    generator.writeln();
    generator.writeln("/* This file has been generated - do not edit */");
    generator.writeln();

    generator.writeDocs(
        'A library to expose the Chrome ${name} APIs.',
        preferSingle: true);
    generator.writeln("library chrome_${name};");
    generator.writeln();

    for (String libName in libraryNames) {
      generator.writeln(
          "export 'gen/${convertJSLibNameToFileName(libName)}.dart';");
    }

    libFile.writeAsStringSync(generator.toString());
    print('wrote ${libFile.path}');

    if (alreadyWritten != null) {
      libraryNames.removeWhere((e) => alreadyWritten.contains(e));
    }

    TranslationContext context = new TranslationContext.fromOverrides(
        JSON.decode(overridesFile.readAsStringSync()));

    for (String libName in libraryNames) {
      _generateFile(context, libName);
    }
  }

  void _generateFile(TranslationContext context, String jsLibName) {
    String fileName = convertJSLibNameToFileName(jsLibName);
    String locateName = fileName.replaceFirst("devtools_", "devtools/");

    File jsonFile = new File("${idlDir.path}/${locateName}.json");
    File idlFile = new File("${idlDir.path}/${locateName}.idl");

    File outFile = new File("${outDir.path}/gen/${fileName}.dart");

    if (jsonFile.existsSync()) {
      GenApiFile apiGen = new GenApiFile(jsonFile, outFile, context);
      apiGen.generate();
    } else if (idlFile.existsSync()) {
      GenApiFile apiGen = new GenApiFile(idlFile, outFile, context);
      apiGen.generate();
    } else {
      print("Unable to locate idl or json file for '${jsLibName}'.");
      exit(1);
    }
  }
}