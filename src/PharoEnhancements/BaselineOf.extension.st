Extension { #name : #BaselineOf }

{ #category : #'*PharoEnhancements' }
BaselineOf class >> exampleSupportFolder [
	^ self iceRepository location / 'example support'
]

{ #category : #'*PharoEnhancements' }
BaselineOf class >> iceRepository [
	"Unlike RPackage>>#iceRepository, I work with non-MC e.g. git"
	^ IceRepository registry detect: [ :e | e includesPackageNamed: self package name ].
]
