# BaseWordList.coffee

import {
	undef, defined, notdefined, isArrayOfHashes, isString, isArray,
	getOptions,
	} from '@jdeighan/base-utils'
import {assert, croak} from '@jdeighan/base-utils/exceptions'
import {Word} from '@jdeighan/spaced-rep/Word'

lBaseWords = undef     # filled in at end of this file
hDefOptions = {}

# ---------------------------------------------------------------------------

export class BaseWordList

	constructor: (hOptions={}) ->

		@hOptions = getOptions(hOptions, hDefOptions)
		@lWords = @load()        # --- an array of Word objects
		@nextUnseenWordPos = 0   #     support @getUnseen()
		@size = @lWords.length
		assert (@size > 0), "No words in list"

	# ..........................................................

	getUnseen: () ->
		# --- Returns undef if no more words available

		if (@nextUnseenWordPos == @size)
			return undef
		word = @wordAt(@nextUnseenWordPos)
		@nextUnseenWordPos += 1
		return word

	# ..........................................................

	word: (lang, str) ->

		for obj in @lWords
			if obj.hasOwnProperty(lang)
				x = obj[lang]
				if isString(x) && (x == str)
					return obj
				else if isArray(x) && (x.indexOf(str) >= 0)
					return obj
		return undef

	# ..........................................................

	wordAt: (index) ->

		assert (index < @size), "No word at index #{index}"
		return @lWords[index]

	# ..........................................................

	load: () ->

		lWords = []
		for h in lBaseWords
			lWords.push new Word(h)
		return lWords

# ---------------------------------------------------------------------------

lBaseWords = [
	# --- First, the numbers 1..10
	{
		zh: '一'
		pinyin: 'yī'
		en: 'one'
		es: 'uno'
		}
	{
		zh: '二'
		pinyin: 'èr'
		en: 'two'
		es: 'dos'
		}
	{
		zh: '三'
		pinyin: 'sān'
		en: 'three'
		es: 'tres'
		}
	{
		zh: '四'
		pinyin: 'sì'
		en: 'four'
		es: 'quatro'
		}
	{
		zh: '五'
		pinyin: 'wǔ'
		en: 'five'
		es: 'cinco'
		}
	{
		zh: '六'
		pinyin: 'liù'
		en: 'six'
		es: 'seis'
		}
	{
		zh: '七'
		pinyin: 'qī'
		en: 'seven'
		es: 'siete'
		}
	{
		zh: '八'
		pinyin: 'bā'
		en: 'eight'
		es: 'ocho'
		}
	{
		zh: '九'
		pinyin: 'jiǔ'
		en: 'nine'
		es: 'nueve'
		}
	{
		zh: '十'
		pinyin: 'shí'
		en: 'ten'
		es: 'diez'
		}

	# --- some additional words
	{
		zh: '死'
		pinyin: 'sǐ'
		en: ['die', 'pass away']
		}
	{
		zh: '需要'
		pinyin: 'xū yào'
		en: 'need'
		}
	]
