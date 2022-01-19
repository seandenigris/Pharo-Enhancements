Extension { #name : #Class }

{ #category : #'*PharoEnhancements' }
Class >> gitHubUrl [

	^ self package gitHubUrl addPathSegment: self name, '.class.st'
]
