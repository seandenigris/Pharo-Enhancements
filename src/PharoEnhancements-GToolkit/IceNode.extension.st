Extension { #name : #IceNode }

{ #category : #'*PharoEnhancements-GToolkit' }
IceNode >> peGtViewLepiterPageDiffFor: aView [

	<gtView>
	| newPage oldPage |
	((self definition isKindOf: GtLepiterPageDefinition) not
		or: [ self value leftContents isEmpty ]) ifTrue: [ ^ aView empty ].
		
	oldPage := self value rightContents ifNotEmpty: [ (LeJsonV4 new deserialize: self value rightContents readStream) asMarkdownString ]
		ifEmpty: [ '' ].
	
	^ aView forward
		title: 'Markdown Diff';
		priority: 10;
		object: [ 
			newPage := LeJsonV4 new deserialize: self value leftContents readStream.
			PeCharacterDiff comparing: newPage asMarkdownString to: oldPage ];
			view: #gtViewTextFor:
]
