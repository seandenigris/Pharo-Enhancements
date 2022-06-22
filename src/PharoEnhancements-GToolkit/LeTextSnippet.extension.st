Extension { #name : #LeTextSnippet }

{ #category : #'*PharoEnhancements-GToolkit' }
LeTextSnippet >> gtASTFor: aView [
	<gtView>
	self hasText
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'AST';
		priority: 10;
		object: [ LeParser parse: self text asString ];
		view: #gtExploreFor:
]
