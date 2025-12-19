Class {
	#name : 'PeTomlParseNode',
	#superclass : 'SmaCCParseNode',
	#category : 'PharoEnhancements-GToolkit-TOML',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'TOML'
}

{ #category : 'generated' }
PeTomlParseNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitParse: self
]
