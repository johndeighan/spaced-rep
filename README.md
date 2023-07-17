The spaced repetition algorithm
===============================

The algorithm is implemented via a `WordList` object in
the following methods:

	- getNextWordToLearn()
	- resultWas()

The `WordList` class extends the `BaseWordList` class.

A `BaseWordList object contains `Word`s, each of which is
a hash with language codes as keys (e.g. 'en' is English,
'zh' is Chinese, etc.) where the values are the given
word in the given language. The method `getUnseen`
returns the words in order of "importance", roughly amount
of usage or difficulty. Each `Word` object (hash) also
includes the following keys:

	index - order of the Word in the `BaseWordList`
	state - undef for words in the `unseen set`
	        'working' for words in the 'working set'
	        'learned' for words in the 'learned set'
	dueAt - timestamp when word is due if in 'working set'
	lHistory - array of result values if in 'working set'
	numCorrect - number of correct reviews if in 'learned set'

In a `WordList` object:

1. Any words in the `LearnedWords` object exist in only
	one of 3 sets: 1) The `unseen` set, 2) the `working`
	set or 3) the `learned` set

2. Initially, all words in the `WordList` are in the
	`unseen` set. The `BaseWordList` class maintains the
	words in an ordered array and has a property named
	`nextUnseenWordPos`, initially 0. The words at this
	position and higher are implicitly the `unseen` set.
	When the method `getUnseen()` is called, the
	word at this position is returned and the property is
	incremented by 1.

3. Each word in the `learned set` is stored in the array
	`lLearned[n] where n is the number of times this word
	was correctly identified in a review (i.e. after
	passing the `working` phase). That is, lLearned is
	an array of arrays. The word will also have a key
	named `numCorrect` which is set to n.

4. Each `Word` in the `working set` has a field named
	`history` which is an array of results achieved during
	testing (currently only RIGHT=1, WRONG=2).
	It also has a field named `dueAt` specifying the date and
	time that the word is **due**

5. Both the `working set` and the `learned set` are
	maintained in the order of the `dueAt` field

Algorithm for getNextWordToLearn()
----------------------------------

if we want a review word
	find 1st word in lLearned that is not state 'review'
	mark it as state 'review'
	return it
else
	find 1st word in lWorking that is not state 'working'
	if it exists and is due
		mark it as state 'working
		return it
	else if lWorking.size < workingSetSize
		get another word from 'unseen set'
		push it onto lWorking
		set state to 'working
		return that word
	elsif next word in the `working set` exists and is due
		return that word
	elsif size of `working set` < **workingSetSize**
		retrieve next word in `unseen set`
		if word is defined
			place that word in the `working set`
			return that word
		else
			we're done!!!


A Word can be in any of 3 states: 1) 'unseen', 2) 'learning'
or 3) 'learned'. All words are initially in the 'unseen' state.
The following events are possible:

State 'unseen'
	FETCH
		setState 'learning', {lHistory: []}

State 'learning'
	TEST
		setState 'testing', {outcome: undef}

State 'testing'
	TEST_OUTCOME
		assert defined(outcome, lHistory)
		append outcome to lHistory
		while lHistory.size > 5
			remove 1st item in lHistory
		if lHistory is 5 correct
			setState 'learned', {numReviews: 0}
		else
			setState 'learning'

State 'learned'
	REVIEW
		setState 'reviewing', {outcome: undef}

State 'reviewing'
	REVIEW_OUTCOME
		assert defined(outcome)
		if outcome == RIGHT
			increment numReviews
			setState 'learned'
		else
			setState 'learning', {lHistory: []}

