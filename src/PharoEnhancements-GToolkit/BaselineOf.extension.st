Extension { #name : #BaselineOf }

{ #category : #'*PharoEnhancements-GToolkit' }
BaselineOf class >> gitHubComment [
	| page visitor |
	page := LePharoClassDatabase uniqueInstance pageNamed: self name.
	visitor := LeGitHubExporterVisitor new
		shouldIncludeTitle: false;
		yourself.
	page acceptVisitor: visitor.
	^ visitor stream contents
]

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

{ #category : #'*PharoEnhancements-GToolkit' }
BaselineOf class >> loadGtIconFromRepositoryPath: aString [
	"aString - partial path from repository root folder"
	
	| result iconFile |
	iconFile := self iceRepository location / aString.
	result := ImageReadWriter formFromFileNamed: iconFile.
	^ result asElement asScalableElement
		size: 16 @ 16;
		yourself
]

{ #category : #'*PharoEnhancements-GToolkit' }
BaselineOf class >> loadLepiterDocumentation [
	self lepiter databases do: #load
]
