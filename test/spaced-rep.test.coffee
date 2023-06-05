# spaced-rep.test.coffee

import {utest} from '@jdeighan/unit-tester'
import {getNextWord} from '@jdeighan/spaced-rep'

# ---------------------------------------------------------------------------

utest.like 8, getNextWord(), {
	pinyin: 'yī'
	en: 'one'
	zh: '一'
	}

