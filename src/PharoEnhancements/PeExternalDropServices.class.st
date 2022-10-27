Class {
	#name : #PeExternalDropServices,
	#superclass : #Object,
	#category : #PharoEnhancements
}

{ #category : #accessing }
PeExternalDropServices class >> itemsFor: anObject [
	"Answer a list of services appropriate for an object"

	| services |
	services := OrderedCollection new.
	(Pragma allNamed: #peDropService)
		do: [ :each |
			| newServices |
			newServices := each methodClass soleInstance
						perform: each methodSelector
						withArguments: { anObject }.
			newServices do: [ :svc | svc argumentGetter: [ :obj | obj ] ].
			services addAll: newServices ].
	^ services
]
