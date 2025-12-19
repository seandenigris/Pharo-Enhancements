Extension { #name : 'Package' }

{ #category : '*PharoEnhancements' }
Package >> peIceRepository [
	"Unlike RPackage>>#iceRepository, I work with non-MC e.g. git"
	^ IceRepository registry detect: [ :e | e includesPackageNamed: self name ] ifNone: [ nil ].
]
