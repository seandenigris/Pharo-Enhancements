Class {
	#name : #PeDemoAddressBook,
	#superclass : #PeStaticContactsSnapshot,
	#category : #'PharoEnhancements-Experiments'
}

{ #category : #accessing }
PeDemoAddressBook >> ensureContact: aRelatableEntity [

	"Mimick identit-set-like behavior i.e. avoid duplicates"
	(self privateCollection identityIncludes: aRelatableEntity)
		ifFalse: [ 
			self privateCollection add: aRelatableEntity.
			
			"There is a two-way link, so update the other side as well"
			aRelatableEntity addressBookBasic: self ].
		
	^ aRelatableEntity.
]
