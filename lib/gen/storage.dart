// Copyright (c) 2013, the gen_tools.dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

/* This file has been generated from storage.json - do not edit */

/**
 * Use the `chrome.storage` API to store, retrieve, and track changes to user
 * data.
 */
library chrome.storage;

import '../src/common.dart';

/// Accessor for the `chrome.storage` namespace.
final ChromeStorage storage = new ChromeStorage._();

class ChromeStorage {
  JsObject _storage;

  ChromeStorage._() {
    _storage = context['chrome']['storage'];
  }

  /**
   * Items in the `sync` storage area are synced using Chrome Sync.
   */
  dynamic get sync => _storage['sync'];

  /**
   * Items in the `local` storage area are local to each machine.
   */
  dynamic get local => _storage['local'];

  /**
   * Fired when one or more items change.
   */
  Stream get onChanged => _onChanged.stream;

  final ChromeStreamController _onChanged = null;
}