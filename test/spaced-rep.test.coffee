# spaced-rep.test.coffee

import {utest, UnitTester} from '@jdeighan/unit-tester'
import {LearnedWords} from '@jdeighan/spaced-rep'

words = new LearnedWords('zh', 'en')
oneDay = 1000 * 60 * 60 * 24   # --- one day in milliseconds

# ---------------------------------------------------------------------------

class MyTester extends UnitTester

	transformValue: (numCorrect) ->

		due = words.learnedDueTime({numCorrect})
		return Math.round((due - Date.now()) / oneDay)

tester = new MyTester()

# ---------------------------------------------------------------------------

tester.equal 22, 0, 1
tester.equal 22, 1, 2
tester.equal 22, 2, 4
tester.equal 22, 3, 8

# ---------------------------------------------------------------------------


