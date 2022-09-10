Extension { #name : #Object }

{ #category : #'*PharoEnhancements' }
Object class >> exampleSupportFolder [
	^ self iceRepository location / 'example support'
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
	^ IceRepository registry detect: [ :e | e includesPackageNamed: self package name ] ifNone: [ nil ].
]

{ #category : #'*PharoEnhancements' }
Object >> interestingPointersTo [

| pointers |
	pointers := self pointersTo.
^ pointers reject: [ :e | ({ BlockClosure. Context. OpalCompiler } anySatisfy: [ :cls | e isKindOf: cls])
	or: [ #('Brick' 'GT' 'GToolkit' 'Magritte' 'Lepiter' 'NewTools' 'Spec2') anySatisfy: [ :pkgPre | e class category beginsWith: pkgPre ] ] ].
]

{ #category : #'*PharoEnhancements' }
Object class >> peCanHandleFromString: aString [
	"Return whether the string input is convertible to an instance of this particular class. Subclasses should override as needed"
	
	^ false
]

{ #category : #'*PharoEnhancements' }
Object class >> peClassForString: aString [
	self subclasses do: [ :cls | 
		| matchedSubclass |
		matchedSubclass := cls peClassForString: aString.
		matchedSubclass ifNotNil: [ ^ matchedSubclass ] ].
		
	^ (self peCanHandleFromString: aString)
		ifTrue: [ self ]
		ifFalse: [ nil ]
]

{ #category : #'*PharoEnhancements' }
Object >> pePickUp [
	PeGtSpotterResult := self
]
