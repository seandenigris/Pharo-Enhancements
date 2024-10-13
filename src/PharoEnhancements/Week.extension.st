Extension { #name : #Week }

{ #category : #'*PharoEnhancements' }
Week class >> dayNameParser [
	| rules |
	rules := Array streamContents: [ :s |
		self dayNames collect: [ :e | 
			s nextPut: e asString asPParser.
			s nextPut: (e first: 3) asPParser ] ].
	^ PP2ChoiceNode withAll: rules
]
