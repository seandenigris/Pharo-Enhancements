Extension { #name : 'LeContent' }

{ #category : '*PharoEnhancements-GToolkit' }
LeContent >> peAsGitHubMarkdownString [

	| visitor |
	visitor := LeGitHubExporterVisitor new.
self acceptVisitor: visitor.
	^ visitor stream contents
]
