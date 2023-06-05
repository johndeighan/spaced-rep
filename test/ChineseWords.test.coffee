# ChineseWords.test.coffee

import {utest} from '@jdeighan/unit-tester'
import {hZhWords} from '@jdeighan/spaced-rep/words'

# ---------------------------------------------------------------------------

utest.like 8, hZhWords.死, {
	pinyin: 'sǐ'
	en: 'die, pass away'
	}

utest.like 13, hZhWords.需要, {
	pinyin: 'xū yào'
	en: 'need'
	}
