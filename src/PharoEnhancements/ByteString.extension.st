Extension { #name : 'ByteString' }

{ #category : '*PharoEnhancements' }
ByteString >> asTitleCase [
	"There are several styles (e.g. Chicago, APA, MLA, and AP; see https://capitalizemytitle.com for more info). Here we take a general approach, capitalizing the first word and any word not on one of the lists that start the method (e.g. articles)"
	| articles coordinatingConjunctions prepositions isListed resultBlock caseWord nextWordFromTo isFirstWord |
	articles := #('a' 'an' 'the').
	coordinatingConjunctions := #('and' 'but' 'for' 'nor' 'or' 'so' 'yet').
	"From https://www.thefreedictionary.com/List-of-prepositions.htm"
	prepositions := #(
	"most common"
	'about' 'above' 'across' 'after' 'against' 'among' 'around' 'at' 'before' 'behind' 'below' 'beside ' 'between' 'by' 'down' 'during' 'for' 'from' 'in' 'inside' 'into' 'near' 'of' 'off' 'on' 'out' 'over' 'through' 'to' 'toward' 'under' 'up' 'with' 
	"less common"
	'aboard' 'along' 'amid' 'as' 'beneath' 'beyond' 'but ' 'concerning' 'considering' 'despite' 'except' 'following' 'like' 'minus' 'next' 'onto' 'opposite' 'outside' 'past' 'per' 'plus' 'regarding' 'round' 'save' 'since' 'than' 'till' 'underneath' 'unlike' 'until' 'upon' 'versus' 'via' 'within' 'without').
	
	isFirstWord := true.
	
	isListed := [ :word | { articles. coordinatingConjunctions. prepositions } anySatisfy: [ :col | col includes: word ] ].
	
	caseWord := [ :word | 
		(isFirstWord or: [ (isListed value: word) not ])
			ifTrue: [ word capitalized ]
			ifFalse: [ word ] ].
			
	nextWordFromTo := [ :inStr :outStr |
		| word |
		word := String streamContents: [ :ws |
			[ inStr atEnd not and: [ inStr peek isLetter ] ] whileTrue: [ ws nextPut: inStr next ] ].
		outStr nextPutAll: (caseWord value: word).
		isFirstWord := false.
		[ inStr atEnd or: [ inStr peek isLetter ] ] whileFalse: [ outStr nextPut: inStr next ] ].
	
	resultBlock := [ :outStr |
		| inStr |
		inStr := self trimBoth readStream.
		[ inStr atEnd ] whileFalse: [ nextWordFromTo value: inStr value: outStr ] ].
			
	^ String streamContents: resultBlock
	
	"Implementation note: another way to do this would be to use an existing (non-Pharo) library like https://pypi.org/project/titlecase/. Possibly one could plug in one or the other depending on the environment. For example, outside libraries are likely more mature but come with dependencies.
	
	The model here could get very deep e.g. dictionary for different languages and parts of speech. Some of this is implemented in my foreign language app"
]

{ #category : '*PharoEnhancements' }
ByteString >> copyToClipboard [
	Clipboard clipboardText: self
]

{ #category : '*PharoEnhancements' }
ByteString class >> exampleAsTitleCase [
	<gtExample>
	| result |
	result := 'and the dish ran away with the spoon' asTitleCase.
	self assert: result equals: 'And the Dish Ran Away with the Spoon'
]

{ #category : '*PharoEnhancements' }
ByteString >> htmlDecoded [

	| result table |
	result := self.
	table := Dictionary newFromPairs: {  
		'&nbsp;'. ' '.
		'&quot;'. '"'.
		'&rsquo;'. ''''
	}.
	table keysAndValuesDo: [ :k :v | result := result copyReplaceAll: k with: v ].
	^ result
]
