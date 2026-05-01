Extension { #name : 'Package' }

{ #category : '*PharoEnhancements-GToolkit' }
Package >> gtCommentFor: aView [
	<gtView>
	self packageManifestOrNil ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Comment';
		priority: 0.5;
		object: [ self packageManifest ];
		view: #gtCoderLepiterCommentsFor:
]
