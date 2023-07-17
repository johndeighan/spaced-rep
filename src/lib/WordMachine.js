// Generated by CoffeeScript 2.7.0
// WordMachine.coffee
var hDefOptions;

import {
  undef,
  defined,
  notdefined,
  range,
  deepEqual,
  getOptions
} from '@jdeighan/base-utils';

import {
  StateMachine
} from '@jdeighan/base-utils/machine';

hDefOptions = {
  histLen: 5,
  workingSetSize: 7,
  pctReview: 5
};

// --- Default values used in history list for word in working set
export var RIGHT = 1;

export var WRONG = 2;

// ---------------------------------------------------------------------------
export var WordMachine = class WordMachine extends Machine {
  constructor(hOptions = {}) {
    var histLen, i, j, len, ref;
    super('unseen');
    this.hOptions = getOptions(hOptions, hDefOptions);
    ({histLen} = this.hOptions);
    this.lAllRight = [];
    ref = range(histLen);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      this.lAllRight.push(RIGHT);
    }
  }

  // ..........................................................
  FETCH() {
    this.expectState('unseen');
    this.setState('learning', {
      lHistory: []
    });
    return this;
  }

  // ..........................................................
  TEST() {
    this.expectState('learning');
    this.setState('testing', {
      outcome: undef
    });
    return this;
  }

  // ..........................................................
  TEST_OUTCOME() {
    var histLen, lHistory, outcome;
    this.expectState('testing');
    this.expectDefined('outcome', 'lHistory');
    ({lHistory, outcome} = this.hData);
    ({histLen} = this.hOptions);
    lHistory.push(outcome);
    while (lHistory.length > histLen) {
      lHistory.shift();
    }
    if (deepEqual(lHistory, this.lAllRight)) {
      this.setState('learned', {
        numReviews: 0
      });
    } else {
      this.setState('learning');
    }
    return this;
  }

  // ..........................................................
  REVIEW() {
    this.expectState('learned');
    this.setState('reviewing', {
      outcome: undef
    });
    return this;
  }

  // ..........................................................
  REVIEW_OUTCOME() {
    var numReviews, outcome;
    this.expectState('reviewing');
    this.expectDefined('outcome');
    ({outcome, numReviews} = this.hData);
    if (outcome === RIGHT) {
      this.setVar('numReviews', numReviews + 1);
      setState('learned');
    } else {
      this.setState('learning', {
        lHistory: []
      });
    }
    return this;
  }

};