// Copyright (c) 2013, the gen_tools.dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

/* This file has been generated from i18n.json - do not edit */

/**
 * Use the `chrome.i18n` infrastructure to implement internationalization across
 * your whole app or extension.
 */
library chrome.i18n;

import '../src/common.dart';

/// Accessor for the `chrome.i18n` namespace.
final ChromeI18N i18n = new ChromeI18N._();

class ChromeI18N {
  JsObject _i18n;

  ChromeI18N._() {
    _i18n = context['chrome']['i18n'];
  }

  /**
   * Gets the accept-languages of the browser. This is different from the locale
   * used by the browser; to get the locale, use `window.navigator.language`.
   */
  Future<dynamic> getAcceptLanguages() {
    ChromeCompleter completer = new ChromeCompleter.oneArg((arg) {
      return arg;
    });
    _i18n.callMethod('getAcceptLanguages', [completer.callback]);
    return completer.future;
  }

  /**
   * Gets the localized string for the specified message. If the message is
   * missing, this method returns an empty string (''). If the format of the
   * `getMessage()` call is wrong - for example, _messageName_ is not a string
   * or the _substitutions_ array has more than 9 elements - this method returns
   * `undefined`.
   * 
   * [messageName] The name of the message, as specified in the <a
   * href='i18n-messages.html'>`messages.json`</a> file.
   * 
   * [substitutions] Up to 9 substitution strings, if the message requires any.
   */
  String getMessage(String messageName, var substitutions) {
    return _i18n.callMethod('getMessage', [messageName, substitutions]);
  }
}