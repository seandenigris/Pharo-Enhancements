Class {
	#name : #PeTomlExpressionNode,
	#superclass : #PeTomlParseNode,
	#instVars : [
		'comment'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTomlExpressionNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitExpression: self
]

{ #category : #generated }
PeTomlExpressionNode >> comment [

	^ comment
]

{ #category : #generated }
PeTomlExpressionNode >> comment: aSmaCCToken [

	comment := aSmaCCToken
]

{ #category : #generated }
PeTomlExpressionNode >> tokenVariables [

	^ #( #comment )
]
