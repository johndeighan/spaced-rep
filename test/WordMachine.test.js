// Generated by CoffeeScript 2.7.0
// WordMachine.test.coffee
var word;

import {
  utest
} from '@jdeighan/unit-tester';

import {
  WordMachine
} from '@jdeighan/spaced-rep/WordMachine';

// ---------------------------------------------------------------------------
word = new WordMachine();

word.FETCH().TEST();

utest.truthy(10, word.inState('testing'));
