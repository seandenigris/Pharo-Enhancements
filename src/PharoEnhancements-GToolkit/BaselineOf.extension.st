Extension { #name : #BaselineOf }

{ #category : #'*PharoEnhancements-GToolkit' }
BaselineOf class >> gtExamplesFor: aView [
	<gtView>
	<gtClassView>
	| examples |
	examples := self version packages flatCollect: [ :pSpec |
		| loadedPackage |
		loadedPackage := RPackage organizer packageNamed: pSpec name ifAbsent: [ nil ].
		loadedPackage ifNotNil: [ :p | p gtExamplesContained ] ifNil: [ #() ] ].
	^ (GtExampleGroup withAll: examples) gtExamplesFor: aView
]

{ #category : #'*PharoEnhancements-GToolkit' }
BaselineOf class >> lepiter [
	^ PeLepiterProject fromBaseline: self
]
