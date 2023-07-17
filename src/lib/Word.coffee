# Word.coffee

import {
	undef, defined, notdefined, deepEqual,
	isArrayOfHashes, isString, isArray,
	} from '@jdeighan/base-utils'
import {assert, croak} from '@jdeighan/base-utils/exceptions'

# ---------------------------------------------------------------------------

export class Word

	@nextIndex: 0   # maintain index for each Word object created

	constructor: (h) ->

		# --- Copy all keys from h to "this"
		Object.assign this, h

		@index = Word.nextIndex
		Word.nextIndex += 1

		@state = undef
		@dueAt = undef
		@lHistory = undef
		@numCorrect = undef

	# ..........................................................

	addHistory: (result, maxHist=5) ->

		@numCorrect = undef
		if notdefined(@lHistory)
			@lHistory = []
		@lHistory.push result
		while (@lHistory.length > maxHist)
			_ = @lHistory.shift()
		return

	# ..........................................................

	addCorrect: () ->

		@lHistory = undef
		if defined(@numCorrect)
			@numCorrect += 1
		else
			@numCorrect = 1
		return

	# ..........................................................

	historyIs: (lResults) ->

		return deepEqual(@lHistory, lResults)

	# ..........................................................

	descMS: (desc) ->

		if lMatches = desc.match(///^
				\s*
				( -? \d+ (?: \.\d*)?)
				\s*
				(day|hour|minute|second)
				s?
				\s*
				$///)
			[_, numStr, units] = lMatches
			num = parseInt(numStr, 10)
			switch units
				when 'second'
					return num * 1000
				when 'minute'
					return num * 1000 * 60
				when 'hour'
					return num * 1000 * 60 * 60
				when 'day'
					return num * 1000 * 60 * 60 * 24
				else
					croak "Invalid 'due in' descriptor: '#{desc}'"
		else
			croak "Invalid 'due in' descriptor: '#{desc}'"

	# ..........................................................

	setDueIn: (desc) ->

		@dueAt = Date.now() + @descMS(desc)
		return

	# ..........................................................

	isDue: () ->

		if notdefined(@dueAt)
			return true
		else
			return @dueAt < Date.now()
