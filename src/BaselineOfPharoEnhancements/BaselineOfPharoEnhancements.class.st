Class {
	#name : #BaselineOfPharoEnhancements,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoEnhancements
}

{ #category : #baseline }
BaselineOfPharoEnhancements >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec baseline: 'Magritte' with: [ spec repository: 'github://seandenigris/Magritte' ].
		spec 
			package: 'PharoEnhancements';
			package: 'PharoEnhancements-Magritte' with: [ 
				spec requires: #('PharoEnhancements' 'Magritte') ].
		spec group: 'default' with: #('PharoEnhancements') ]
]
