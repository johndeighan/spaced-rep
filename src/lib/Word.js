// Generated by CoffeeScript 2.7.0
  // Word.coffee
import {
  undef,
  defined,
  notdefined,
  deepEqual,
  isArrayOfHashes,
  isString,
  isArray
} from '@jdeighan/base-utils';

import {
  Machine
} from '@jdeighan/base-utils/machine';

import {
  assert,
  croak
} from '@jdeighan/base-utils/exceptions';

export var Word = (function() {
  // ---------------------------------------------------------------------------
  class Word {
    constructor(h) {
      // --- Copy all keys from hWord to "this"
      Object.assign(this, h);
      this.index = Word.nextIndex;
      Word.nextIndex += 1;
      this.state = undef;
      this.dueAt = undef;
      this.lHistory = undef;
      this.numCorrect = undef;
    }

    // ..........................................................
    addHistory(result, maxHist = 5) {
      var _;
      this.numCorrect = undef;
      if (notdefined(this.lHistory)) {
        this.lHistory = [];
      }
      this.lHistory.push(result);
      while (this.lHistory.length > maxHist) {
        _ = this.lHistory.shift();
      }
    }

    // ..........................................................
    addCorrect() {
      this.lHistory = undef;
      if (defined(this.numCorrect)) {
        this.numCorrect += 1;
      } else {
        this.numCorrect = 1;
      }
    }

    // ..........................................................
    historyIs(lResults) {
      return deepEqual(this.lHistory, lResults);
    }

    // ..........................................................
    descMS(desc) {
      var _, lMatches, num, numStr, units;
      if (lMatches = desc.match(/^\s*(-?\d+(?:\.\d*)?)\s*(day|hour|minute|second)s?\s*$/)) {
        [_, numStr, units] = lMatches;
        num = parseInt(numStr, 10);
        switch (units) {
          case 'second':
            return num * 1000;
          case 'minute':
            return num * 1000 * 60;
          case 'hour':
            return num * 1000 * 60 * 60;
          case 'day':
            return num * 1000 * 60 * 60 * 24;
          default:
            return croak(`Invalid 'due in' descriptor: '${desc}'`);
        }
      } else {
        return croak(`Invalid 'due in' descriptor: '${desc}'`);
      }
    }

    // ..........................................................
    setDueIn(desc) {
      this.dueAt = Date.now() + this.descMS(desc);
    }

    // ..........................................................
    isDue() {
      if (notdefined(this.dueAt)) {
        return true;
      } else {
        return this.dueAt < Date.now();
      }
    }

  };

  Word.nextIndex = 0; // maintain index for each Word object created

  return Word;

}).call(this);
