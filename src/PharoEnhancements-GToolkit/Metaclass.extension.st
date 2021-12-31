Extension { #name : #Metaclass }

{ #category : #'*PharoEnhancements-GToolkit' }
Metaclass >> classVariableNamed: aString ifAbsent: absentBlock [
	"Fixes https://github.com/feenkcom/gtoolkit/issues/2327"

	^self classPool associationAt: aString asSymbol ifAbsent: absentBlock
]
