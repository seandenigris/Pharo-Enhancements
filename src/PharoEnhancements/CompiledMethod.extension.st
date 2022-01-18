Extension { #name : #CompiledMethod }

{ #category : #'*PharoEnhancements' }
CompiledMethod >> gitUrl [

	self package gitUrl file: self name, '.extension.st'
]
