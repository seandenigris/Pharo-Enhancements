Class {
	#name : #'PeAST_Transformer',
	#superclass : #Object,
	#instVars : [
		'ast',
		'isMethod'
	],
	#category : #PharoEnhancements
}

{ #category : #'instance creation' }
PeAST_Transformer class >> on: anRBNode [
	"For a method, pass its #parseTree, not #ast (which is not generally what you want when you're modifying it)"

	^ self new
		ast: anRBNode;
		yourself
]

{ #category : #transforming }
PeAST_Transformer >> addStatementFirst: aString [  
	| node |
	node := Smalltalk compilerClass new
		source: aString;
		parseExpression.
	self ast body addNodeFirst: node.
]

{ #category : #transforming }
PeAST_Transformer >> addTemporaryNamed: aSymbol [
	self ast body addTemporaryNamed: aSymbol
]

{ #category : #accessing }
PeAST_Transformer >> ast [
	^ ast
]

{ #category : #accessing }
PeAST_Transformer >> ast: anRBNode [ 
	ast := anRBNode
]

{ #category : #configuring }
PeAST_Transformer >> beScript [
	isMethod := false
]

{ #category : #testing }
PeAST_Transformer >> isMethod [
	^ isMethod ifNil: [ true ]
]

{ #category : #testing }
PeAST_Transformer >> isVariableDefined: aRBVariableNode [
	^ self rootNode allVariables anySatisfy: [ :e | e name = aRBVariableNode name ]
]

{ #category : #configuring }
PeAST_Transformer >> newSource [

	| undeclaredVariables |
	undeclaredVariables := self rootNode allVariables asSet reject: [ :e | 
		"Not sure why we have to do this. Classes were showing up as variable nodes instead of Global nodes, but can't generally reproduce"
		Smalltalk hasClassNamed: e name ].
	undeclaredVariables
		do: [ :e | 
			self rootNode allDefinedVariables
				detect: [ :symbol | e name = symbol ]
				ifNone: [ self addTemporaryNamed: e name ] ].
	^ self rootNode newSource
]

{ #category : #transforming }
PeAST_Transformer >> replaceNodesSelect: aBlock withNode: aRBVariableNode [
	self ast allChildren
		select: aBlock
		thenDo: [ :e | e parent replaceNode: e withNode: aRBVariableNode ]
]

{ #category : #testing }
PeAST_Transformer >> rootNode [
	^ self isMethod
		ifTrue: [ self ast ]
		ifFalse: [ self ast body ]
]
