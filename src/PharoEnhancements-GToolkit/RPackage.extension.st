Extension { #name : #RPackage }

{ #category : #'*PharoEnhancements-GToolkit' }
RPackage >> gtCommentFor: aView [
	<gtView>
	self packageManifestOrNil ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Comment';
		priority: 0.5;
		object: [ self packageManifest ];
		view: #gtCoderLepiterCommentsFor:
]

{ #category : #'*PharoEnhancements-GToolkit' }
RPackage >> gtDefinedClassesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Classes';
		priority: 1;
		items: [ (self classes sorted: [ :a :b | a name < b name ])
				"collect: #asRingDefinition
				as: OrderedCollection" ];
		column: 'Name' text: [ :aRing | aRing name ];
		column: 'Category' text: [ :aRing | aRing category ]
]
