Extension { #name : #Object }

{ #category : #'*PharoEnhancements' }
Object >> fuelOut [
	| target |
	target := FileLocator imageDirectory / self printString asFileName, 'fuel'.
	self serializeToFileNamed: target nextVersion fullName
]

{ #category : #'*PharoEnhancements' }
Object class >> given: givenBlock when: whenBlock then: thenBlock [
	"Useful for most common example pattern. Example usage in comment below"
	| result |
	givenBlock value.
	result := whenBlock value.
	thenBlock value: result.
	^ result.
	
	"MyDomainClass class>>#example
	<gtExample>
	^ self
		given: []
		when: [ MyDomainClass new ]
		then: [ :it | self assert: it isEmpty ]."
]
