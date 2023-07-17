# WordMachine.coffee

import {
	undef, defined, notdefined, range, deepEqual, getOptions,
	} from '@jdeighan/base-utils'
import {StateMachine} from '@jdeighan/base-utils/machine'

hDefOptions = {
	histLen: 5
	workingSetSize: 7
	pctReview: 5
	}

# --- Default values used in history list for word in working set
export RIGHT = 1
export WRONG = 2

# ---------------------------------------------------------------------------

export class WordMachine extends Machine

	constructor: (hOptions={}) ->

		super 'unseen'
		@hOptions = getOptions hOptions, hDefOptions
		{histLen} = @hOptions

	# ..........................................................
	# --- Default algorithm for determining whether a word is learned

	isLearned: () =>

		@expectState 'learning'

		numRight = 0
		numWrong = 0
		for item in @lHistory
			if (item == RIGHT)
				numRight += 1
			else if (item == WRONG)
				numWrong += 1
		return (numRight - numWrong) >= 5

	# ..........................................................

	FETCH: () ->

		@expectState 'unseen'
		@setState 'learning', {lHistory: []}
		return this

	# ..........................................................

	TEST: () ->

		@expectState 'learning'
		@setState 'testing', {outcome: undef}
		return this

	# ..........................................................

	TEST_OUTCOME: () ->

		@expectState 'testing'
		@expectDefined 'outcome', 'lHistory'

		{lHistory, outcome} = @hData
		{histLen} = @hOptions

		lHistory.push outcome
		while (lHistory.length > histLen)
			lHistory.shift()
		if @isLearned()
			@setState 'learned', {numReviews: 0}
		else
			@setState 'learning'
		return this

	# ..........................................................

	REVIEW: () ->

		@expectState 'learned'
		@setState 'reviewing', {outcome: undef}
		return this

	# ..........................................................

	REVIEW_OUTCOME: () ->

		@expectState 'reviewing'
		@expectDefined 'outcome'

		{outcome, numReviews} = @hData
		if (outcome == RIGHT)
			@setVar('numReviews', numReviews + 1)
			setState 'learned'
		else
			@setState 'learning', {lHistory: []}
		return this
