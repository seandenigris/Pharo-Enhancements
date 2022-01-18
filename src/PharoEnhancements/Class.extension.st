Extension { #name : #Class }

{ #category : #'*PharoEnhancements' }
Class >> gitUrl [

	^ self package gitUrl file: self name, '.class.st'
]
