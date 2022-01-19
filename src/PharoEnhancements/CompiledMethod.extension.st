Extension { #name : #CompiledMethod }

{ #category : #'*PharoEnhancements' }
CompiledMethod >> gitHubUrl [

	^ self isExtension
		ifFalse: [ self methodClass gitHubUrl ]
		ifTrue: [ self package gitHubUrl addPathSegment: self methodClass name, '.extension.st' ]
]
