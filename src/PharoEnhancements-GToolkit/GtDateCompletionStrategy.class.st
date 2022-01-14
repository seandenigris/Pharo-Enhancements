Class {
	#name : #GtDateCompletionStrategy,
	#superclass : #GtStreamedCompletionStrategy,
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
GtDateCompletionStrategy >> candidateClasses [
	^  candidateClasses ifNil: [ 
			| theInterestingClassNames |
			theInterestingClassNames := Smalltalk globals classNames copyWithoutAll: (excludedClasses collect: [ :eachClass | eachClass name ]).
			candidateClasses := GtPrefixTree withAll: theInterestingClassNames ]
]

{ #category : #accessing }
GtDateCompletionStrategy >> completionActionStreamFor: aText at: positionInteger [
	| currentInput |
	currentInput := aText asString.
	"currentInput isEmpty ifTrue: [ ^ #() ]."
	"^ (self candidateClasses asyncStreamStartingWith: currentInput)
		collect:
			[ :className | 
			| deletion insertion |
			deletion := positionInteger < currentInput size
				ifTrue:
					[ GtDeleteTextCompletionAction
						labeled: className
						from: positionInteger + 1
						to: currentInput size ].
			insertion :=" ^ GtInsertTextCompletionAction
				labeled: ('self labelFor: className withSearch: currentInput')
				completion: Date today asString"(className allButFirst: positionInteger)"
				position: positionInteger
				from: 1."
			deletion notNil
				ifTrue:
					[ (GtCompositeCompletionAction labeled: insertion displayText)
						addAction: deletion;
						addAction: insertion;
						yourself ]
				ifFalse: [ insertion ] ]"
]

{ #category : #accessing }
GtDateCompletionStrategy >> completionResultFor: aText at: positionInteger requested: aBoolean [
	^ GtCalendarCompletionResult forDate: Date today andInterval: (1 to: 1)
		"onStream:
			(self
				completionActionStreamFor: aText
				at: positionInteger
				requested: aBoolean)"
]

{ #category : #testing }
GtDateCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]
