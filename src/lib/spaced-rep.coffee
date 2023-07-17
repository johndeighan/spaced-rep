# spaced-rep.coffee

import {
	undef, defined, notdefined, getOptions, OL,
	isEmpty, nonEmpty, isString, isArray,
	} from '@jdeighan/base-utils'
import {assert, croak} from '@jdeighan/base-utils/exceptions'
import {dbgEnter, dbgReturn, dbg} from '@jdeighan/base-utils/debug'
import {BaseWordList} from '@jdeighan/spaced-rep/basewordlist'

hDefOptions = {
	histLen: 5
	workingSetSize: 7
	pctReview: 5
	}

# --- Default values used in history list for word in working set
RIGHT = 1
WRONG = 2

# ---------------------------------------------------------------------------

export class WordList extends BaseWordList

	constructor: (hOptions={}) ->

		super hOptions
		@lWorking = []
		@lLearned = []

	# ..........................................................

	getNextWordToLearn: () ->

		{workingSetSize} = @hOptions
		if (@lLearned.length > 0) && @lLearned[0].isDue()
			return @lLearned[0]
		else if (@lWorking.length > 0) && @lWorking[0].isDue()
			return @lWorking[0]
		else if (@lWorking.length < workingSetSize)
			word = @getUnseen()
			if defined(word)
				@lWorking.push word
				return word
			else
				return undef    # no more words to learn
		else
			return @lWorking[0]

	# ..........................................................

	resultWas: (word, result) ->

		{workingSetSize} = @hOptions
		{lHistory, numCorrect} = word
		if defined(numCorrect)
			if result == RIGHT
				word.addCorrect()
			else if result == WRONG
				# --- was a known word, but got it wrong
				word.addHistory WRONG

				# --- Move it from lLearned to lWorking
				# =============== TO DO ==============
		else if defined(lHistory)
			word.addHistory result
		lHist = @getHist(hWord)
		@lHist.push(result)
		if @lHist.length > workingSetSize
			@lHist.shift()
		return

	# ..........................................................

	learnedOffset: (word) ->
		# --- Returns a string like '10 minutes', '1 day', etc.

		dbgEnter 'learnedOffset', word
		{numCorrect} = word
		assert defined(numCorrect), "Missing 'numCorrect' field"
		numDays = 2 ** numCorrect
		dbg "numDays = #{numDays}"
		result = "#{numDays} days"
		dbg "result = #{result}"
		dbgReturn 'learnedOffset', result
		return result

	# ..........................................................

	workingOffset: (word) ->
		# --- Returns a string like '10 minutes', '1 day', etc.

		dbgEnter 'workingOffset', word
		{history} = word
		assert isArray(history), "Missing 'history' field"
		numMinutes = 2
		for item in history
			switch item
				when RIGHT
					numMinutes *= 2
				when WRONG
					numMinutes /= 2
				else
					croak "Invalid history item: #{OL(item)}"

		dbg "numMinutes = #{numMinutes}"
		result = "#{numMinutes} minutes"
		dbg "result = #{result}"
		dbgReturn 'workingOffset', result
		return result

# ---------------------------------------------------------------------------

export class LearnedWords

	# ..........................................................

	workingDueTime: (hWord) ->
		# --- Returns a timestamp, i.e. num millisecs since the epoch

		dbgEnter 'workingDueTime', hWord

	# ..........................................................

	isDue: (hWord) ->

		{dueAt} = hWord
		if notdefined(dueAt)
			return true
		else
			return dueAt < Date.now()

	# ..........................................................

	getNextWordToLearn: () ->

		if isEmpty(@hLearning)
			hWord = @wordList.wordAt(0)
			return hWord
		else
			croak "not implemented"

	# ..........................................................
	# --- Get current word's history

	getHist: (hWord) ->

		if hWord.hasOwnProperty('history')
			return hWord.history
		else
			hWord.history = []
			return hWord.history

	# ..........................................................

