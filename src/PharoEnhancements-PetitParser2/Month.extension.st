Extension { #name : #Month }

{ #category : #'*PharoEnhancements-PetitParser2' }
Month class >> nameParser [
	| monthRules |
	monthRules := Array streamContents: [ :s |
		MonthNames collect: [ :e | 
			s nextPut: e asString asPParser.
			s nextPut: (e first: 3) asPParser ] ].
	^ PP2ChoiceNode withAll: monthRules
]
