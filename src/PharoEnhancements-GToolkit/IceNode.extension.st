Extension { #name : #IceNode }

{ #category : #'*PharoEnhancements-GToolkit' }
IceNode >> peGtViewLepiterPageDiffFor: aView [

	<gtView>
	| newPage oldPage |
	(self value leftContents isEmpty 
		or: [ self value rightContents isEmpty 
			or: [ (self definition isKindOf: GtLepiterPageDefinition) not ] ]) ifTrue: [ ^ aView empty ].
	
	^ aView forward
		title: 'Markdown Diff';
		priority: 10;
		object: [ 
			newPage := LeJsonV4 new deserialize: self value leftContents readStream.
			oldPage := LeJsonV4 new deserialize: self value rightContents readStream.
			PeCharacterDiff comparing: newPage asMarkdownString to: oldPage asMarkdownString ];
			view: #gtViewTextFor:
]
