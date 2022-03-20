Class {
	#name : #PeTomlNode,
	#superclass : #SmaCCParseNode,
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTomlNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitToml: self
]
