# WordMachine.test.coffee

import {utest} from '@jdeighan/unit-tester'
import {WordMachine} from '@jdeighan/spaced-rep/WordMachine'

# ---------------------------------------------------------------------------

word = new WordMachine()
word.FETCH().TEST()
utest.truthy 10, word.inState('testing')
