# Word.test.coffee

import {undef} from '@jdeighan/base-utils'
import {utest} from '@jdeighan/unit-tester'
import {Word} from '@jdeighan/spaced-rep/Word'

(() ->
	word1 = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})

	word2 = new Word({
		zh: '二'
		pinyin: 'èr'
		en: 'two'
		})

	utest.like 20, word1, {
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		index: 0
		dueAt: undef
		lHistory: undef
		numCorrect: undef
		}

	utest.like 30, word2, {
		zh: '二'
		pinyin: 'èr'
		en: 'two'
		index: 1
		dueAt: undef
		lHistory: undef
		numCorrect: undef
		}
	)()

# ---------------------------------------------------------------------------

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})

	utest.equal 50, word.descMS('0 seconds'), 0
	utest.equal 51, word.descMS('0 minutes'), 0
	utest.equal 52, word.descMS('0 hours'), 0
	utest.equal 53, word.descMS('0 days'), 0

	utest.equal 55, word.descMS('1 second'), 1000
	utest.equal 56, word.descMS('1 minute'), 1000 * 60
	utest.equal 57, word.descMS('1 hour'), 1000 * 60 * 60
	utest.equal 58, word.descMS('1 day'), 1000 * 60 * 60 * 24

	utest.equal 60, word.descMS('2 seconds'), 2000
	utest.equal 61, word.descMS('2 minutes'), 2000 * 60
	utest.equal 62, word.descMS('2 hours'), 2000 * 60 * 60
	utest.equal 63, word.descMS('2 days'), 2000 * 60 * 60 * 24

	utest.equal 65, word.descMS('-1 second'), -1000
	utest.equal 66, word.descMS('-1 minute'), -1000 * 60
	utest.equal 67, word.descMS('-1 hour'), -1000 * 60 * 60
	utest.equal 68, word.descMS('-1 day'), -1000 * 60 * 60 * 24
	)()

# ---------------------------------------------------------------------------

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})
	word.addHistory 13
	word.addHistory 42

	utest.like 82, word, {
		dueAt: undef
		lHistory: [13, 42]
		numCorrect: undef
		}
	)()

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})
	word.addHistory 13
	word.addHistory 42
	word.addCorrect()
	word.addCorrect()

	utest.like 100, word, {
		dueAt: undef
		lHistory: undef
		numCorrect: 2
		}
	)()

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})
	word.addHistory 13
	word.addHistory 42
	word.addCorrect()
	word.addCorrect()
	word.addHistory 1
	word.addHistory 2
	word.addHistory 3
	word.addHistory 4
	word.addHistory 5
	word.addHistory 6

	utest.like 124, word, {
		dueAt: undef
		lHistory: [2,3,4,5,6]
		numCorrect: undef
		}

	word.setDueIn('2 hours')
	utest.falsy 131, word.isDue()
	)()

# ---------------------------------------------------------------------------

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})

	word.addHistory 5
	word.addHistory 5
	word.addHistory 5
	utest.truthy 146, word.historyIs([5,5,5])
	utest.falsy  147, word.historyIs([5,5,5,5])
	utest.falsy  148, word.historyIs([5,5])
	utest.falsy  149, word.historyIs([5,3,5])
	)()

# ---------------------------------------------------------------------------

(() ->
	word = new Word({
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		})

	word.setDueIn('-1 minute')
	utest.truthy 162, word.isDue()
	)()
