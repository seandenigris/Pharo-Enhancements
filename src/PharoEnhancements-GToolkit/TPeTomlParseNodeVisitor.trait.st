Trait {
	#name : #TPeTomlParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitArrayTable: anArrayTable [

	^ self visitParse: anArrayTable
]

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitDocument: aDocument [

	^ self visitParse: aDocument
]

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitExpression: anExpression [

	^ self visitParse: anExpression
]

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitKeyValue: aKeyValue [

	^ self visitParse: aKeyValue
]

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitParse: aParse [

	^ self visitSmaCCParseNode: aParse
]

{ #category : #generated }
TPeTomlParseNodeVisitor >> visitStandardTable: aStandardTable [

	^ self visitParse: aStandardTable
]
