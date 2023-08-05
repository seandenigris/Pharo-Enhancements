Extension { #name : #Symbol }

{ #category : #'*PharoEnhancements' }
Symbol >> valueWithArguments: aCollection [
	^ aCollection first perform: self withArguments: aCollection allButFirst.
	
	"Proposed for Pharo 12: https://github.com/pharo-project/pharo/pull/14439"
]
