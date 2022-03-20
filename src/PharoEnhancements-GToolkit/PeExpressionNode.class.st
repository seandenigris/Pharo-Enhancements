Class {
	#name : #PeExpressionNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'comment'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeExpressionNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitExpression: self
]

{ #category : #generated }
PeExpressionNode >> comment [

	^ comment
]

{ #category : #generated }
PeExpressionNode >> comment: aSmaCCToken [

	comment := aSmaCCToken
]

{ #category : #generated }
PeExpressionNode >> tokenVariables [

	^ #( #comment )
]
