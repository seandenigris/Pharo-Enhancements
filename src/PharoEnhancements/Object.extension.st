Extension { #name : #Object }

{ #category : #'*PharoEnhancements' }
Object class >> exampleSupportFolder [
	^ self iceRepository location / 'example support'
]

{ #category : #'*PharoEnhancements' }
Object >> fuelOut [
	| target |
	target := FileLocator imageDirectory / self printString asFileName, 'fuel'.
	self serializeToFileNamed: target nextVersion fullName
]

{ #category : #'*PharoEnhancements' }
Object class >> given: givenBlock when: whenBlock then: thenBlock [
	"Useful for most common example pattern. Example usage in comment below"
	| whenResult givenResult |
	givenResult := givenBlock value.
	whenResult := whenBlock cull: givenResult.
	thenBlock cull: whenResult cull: givenResult.
	^ whenResult.
	
	"MyDomainClass class>>#example
	<gtExample>
	^ self
		given: [ 1 ]
		when: [ :aNumber | MyDomainClass new number: aNumber; yourself ]
		then: [ :it | self assert: it isEmpty ]."
]

{ #category : #'*PharoEnhancements' }
Object class >> iceRepository [
	"Unlike RPackage>>#iceRepository, I work with non-MC e.g. git"
	^ IceRepository registry detect: [ :e | e includesPackageNamed: self package name ].
]
