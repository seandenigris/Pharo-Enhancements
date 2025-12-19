Extension { #name : 'Class' }

{ #category : '*PharoEnhancements' }
Class >> copyInstVarNamed: sourceName to: targetName [

	self allSubInstancesDo: [ :obj |
		| value |
		value := obj instVarNamed: sourceName.
		obj instVarNamed: #targetName put: value ]
]

{ #category : '*PharoEnhancements' }
Class >> displayName [
	^ (self name allButFirst: 2) piecesCutWhereCamelCase joinUsing: Character space
]

{ #category : '*PharoEnhancements' }
Class >> gitHubMarkdownLink [

	^ '[`', self name, '`](', self gitHubUrl asString, ')'
]

{ #category : '*PharoEnhancements' }
Class >> gitHubUrl [

	^ self package gitHubUrl addPathSegment: self name, '.class.st'
]
