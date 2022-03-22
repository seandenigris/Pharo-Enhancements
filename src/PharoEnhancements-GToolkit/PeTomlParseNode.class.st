Class {
	#name : #PeTomlParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTomlParseNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitParse: self
]
