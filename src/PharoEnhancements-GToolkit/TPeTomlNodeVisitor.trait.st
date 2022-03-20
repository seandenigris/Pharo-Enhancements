Trait {
	#name : #TPeTomlNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
TPeTomlNodeVisitor >> visitArrayTable: anArrayTable [

	^ self visitToml: anArrayTable
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitDocument: aDocument [

	^ self visitToml: aDocument
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitExpression: anExpression [

	^ self visitToml: anExpression
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitKey: aKey [

	^ self visitToml: aKey
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitKeyValue: aKeyValue [

	^ self visitToml: aKeyValue
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitStandardTable: aStandardTable [

	^ self visitToml: aStandardTable
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitToml: aToml [

	^ self visitSmaCCParseNode: aToml
]

{ #category : #generated }
TPeTomlNodeVisitor >> visitValue: aValue [

	^ self visitToml: aValue
]
