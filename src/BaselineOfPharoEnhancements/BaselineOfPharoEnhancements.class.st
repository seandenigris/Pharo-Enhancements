Class {
	#name : #BaselineOfPharoEnhancements,
	#superclass : #BaselineOf,
	#category : 'BaselineOfPharoEnhancements'
}

{ #category : #baseline }
BaselineOfPharoEnhancements >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'PharoEnhancements' ]
]
