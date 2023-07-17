# BaseWordList.test.coffee

import {utest} from '@jdeighan/unit-tester'
import {BaseWordList} from '@jdeighan/spaced-rep/BaseWordList'

words = new BaseWordList('zh', 'en')

# ---------------------------------------------------------------------------

utest.like 10, words.wordAt(0), {
	zh: '一'
	pinyin: 'yī'
	en: 'one'
	}

utest.like 16, words.wordAt(1), {
	zh: '二'
	pinyin: 'èr'
	en: 'two'
	}

# ---------------------------------------------------------------------------

utest.like 24, words.word('zh', '死'), {
	zh: '死'
	pinyin: 'sǐ'
	en: ['die', 'pass away']
	}

utest.like 30, words.word('zh', '需要'), {
	zh: '需要'
	pinyin: 'xū yào'
	en: 'need'
	}

utest.like 36, words.word('en', 'die'), {
	zh: '死'
	pinyin: 'sǐ'
	en: ['die', 'pass away']
	}

utest.like 42, words.word('en', 'need'), {
	zh: '需要'
	pinyin: 'xū yào'
	en: 'need'
	}

# ---------------------------------------------------------------------------

utest.like 50, words.getNextUnseenWord(), {
	pinyin: 'yī'
	en: 'one'
	zh: '一'
	index: 0
	}

utest.like 57, words.getNextUnseenWord(), {
	zh: '二'
	pinyin: 'èr'
	en: 'two'
	index: 1
	}

utest.like 64, words.getNextUnseenWord(), {
	zh: '三'
	pinyin: 'sān'
	en: 'three'
	index: 2
	}

utest.like 71, words.getNextUnseenWord(), {
	zh: '四'
	pinyin: 'sì'
	en: 'four'
	index: 3
	}
