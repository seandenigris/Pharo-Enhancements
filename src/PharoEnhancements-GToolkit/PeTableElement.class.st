Class {
	#name : 'PeTableElement',
	#superclass : 'BlElement',
	#category : 'PharoEnhancements-GToolkit',
	#package : 'PharoEnhancements-GToolkit'
}

{ #category : 'as yet unclassified' }
PeTableElement >> initialize [
	super initialize.
	self layout: BlGridLayout horizontal.
	self layout cellSpacing: 7.
	self background: Color gray.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
]
