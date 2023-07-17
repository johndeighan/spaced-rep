// Generated by CoffeeScript 2.7.0
// BaseWordList.coffee
var lBaseWords;

import {
  undef,
  defined,
  notdefined,
  isArrayOfHashes,
  isString,
  isArray,
  getOptions
} from '@jdeighan/base-utils';

import {
  assert,
  croak
} from '@jdeighan/base-utils/exceptions';

import {
  Word
} from '@jdeighan/spaced-rep/word';

lBaseWords = undef; // filled in at end of this file


  // ---------------------------------------------------------------------------
export var BaseWordList = class BaseWordList {
  constructor(hOptions = {}) {
    this.hOptions = getOptions(hOptions, hDefOptions);
    this.lWords = this.load(); // --- an array of Word objects
    this.nextUnseenWordPos = 0; //     support @getNextUnseenWord()
    this.size = this.lWords.length;
    assert(this.size > 0, "No words in list");
  }

  // ..........................................................
  getNextUnseenWord() {
    var word;
    // --- Returns undef if no more words available
    if (this.nextUnseenWordPos === this.size) {
      return undef;
    }
    word = this.wordAt(this.nextUnseenWordPos);
    this.nextUnseenWordPos += 1;
    return word;
  }

  // ..........................................................
  word(lang, str) {
    var i, len, obj, ref, x;
    ref = this.lWords;
    for (i = 0, len = ref.length; i < len; i++) {
      obj = ref[i];
      if (obj.hasOwnProperty(lang)) {
        x = obj[lang];
        if (isString(x) && (x === str)) {
          return obj;
        } else if (isArray(x) && (x.indexOf(str) >= 0)) {
          return obj;
        }
      }
    }
    return undef;
  }

  // ..........................................................
  wordAt(index) {
    assert(index < this.size, `No word at index ${index}`);
    return this.lWords[index];
  }

  // ..........................................................
  load() {
    var h, i, lWords, len;
    lWords = [];
    for (i = 0, len = lBaseWords.length; i < len; i++) {
      h = lBaseWords[i];
      lWords.push(new Word(h));
    }
    return lWords;
  }

};

// ---------------------------------------------------------------------------
lBaseWords = [
  {
    // --- First, the numbers 1..10
    zh: '一',
    pinyin: 'yī',
    en: 'one',
    es: 'uno'
  },
  {
    zh: '二',
    pinyin: 'èr',
    en: 'two',
    es: 'dos'
  },
  {
    zh: '三',
    pinyin: 'sān',
    en: 'three',
    es: 'tres'
  },
  {
    zh: '四',
    pinyin: 'sì',
    en: 'four',
    es: 'quatro'
  },
  {
    zh: '五',
    pinyin: 'wǔ',
    en: 'five',
    es: 'cinco'
  },
  {
    zh: '六',
    pinyin: 'liù',
    en: 'six',
    es: 'seis'
  },
  {
    zh: '七',
    pinyin: 'qī',
    en: 'seven',
    es: 'siete'
  },
  {
    zh: '八',
    pinyin: 'bā',
    en: 'eight',
    es: 'ocho'
  },
  {
    zh: '九',
    pinyin: 'jiǔ',
    en: 'nine',
    es: 'nueve'
  },
  {
    zh: '十',
    pinyin: 'shí',
    en: 'ten',
    es: 'diez'
  },
  {
    // --- some additional words
    zh: '死',
    pinyin: 'sǐ',
    en: ['die',
  'pass away']
  },
  {
    zh: '需要',
    pinyin: 'xū yào',
    en: 'need'
  }
];
