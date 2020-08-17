Class {
	#name : #BaselineOfPharoEnhancements,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoEnhancements
}

{ #category : #baseline }
BaselineOfPharoEnhancements >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'PharoEnhancements';
			package: 'PharoEnhancements-GToolkit';
			package: 'PharoEnhancements-PetitParser2'.
		spec group: 'default' with: #('PharoEnhancements') ].
	
	spec for: #GToolkit do: [ 
		spec group: 'default' with: #('PharoEnhancements' 'PharoEnhancements-GToolkit') ]
]

{ #category : #accessing }
BaselineOfPharoEnhancements >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #() ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfPharoEnhancements >> isGTImage [
	^ RPackageOrganizer default includesPackageNamed: 'GToolkit-Documenter'
]
