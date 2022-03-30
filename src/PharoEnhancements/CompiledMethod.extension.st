Extension { #name : #CompiledMethod }

{ #category : #'*PharoEnhancements' }
CompiledMethod >> gitHubMarkdownLink [

	^ '[`', self name, '`](', self gitHubUrl asString, ')'
]

{ #category : #'*PharoEnhancements' }
CompiledMethod >> gitHubUrl [

	^ self isExtension
		ifFalse: [ self origin instanceSide gitHubUrl ]
		ifTrue: [ self package gitHubUrl addPathSegment: self origin name, '.extension.st' ]
]
