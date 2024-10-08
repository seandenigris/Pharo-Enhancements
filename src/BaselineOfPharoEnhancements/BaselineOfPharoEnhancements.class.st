"
Useful extensions to Pharo/Gtoolkit Core i.e. things we think should be ''in'' core ;-)
!Wiki(s)
The ${class:PharoWiki}$ is applicable to both vanilla Pharo and GToolkit, but only renders - and so is only loaded by default - in the latter.
To browse it, inspect the following and view the ""Pages"" tab.
[[[language=smalltalk
PharoWiki
]]] 
"
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
			package: #'PharoEnhancements';
			package: #'PharoEnhancements-Magritte';
			package: #'PharoEnhancements-PetitParser2';
			package: #'PharoEnhancements-PolyMath'.
		spec group: #'default' with: #(PharoEnhancements) ].
	
	spec for: #GToolkit do: [ 
		spec package: #'PharoEnhancements-GToolkit'.
		spec group: #'default' with: #(#'PharoEnhancements-GToolkit' #'PharoEnhancements-PetitParser2') ]
]

{ #category : #accessing }
BaselineOfPharoEnhancements >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfPharoEnhancements >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
