Extension { #name : #IcePackageDefinition }

{ #category : #'*PharoEnhancements' }
IcePackageDefinition >> target [
	^ RPackage organizer packageNamed: self name
]
