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
		spec baseline: 'ActivePapers' with: [ spec repository: 'github://seandenigris/activepapers-pharo:denigris' ].
		spec
			package: 'PharoEnhancements';
			package: 'PharoEnhancements-GToolkit';
			package: 'PharoEnhancements-PetitParser2';
			package: 'PharoWiki' with: [ spec requires: #('ActivePapers') ].
		spec group: 'default' with: #('PharoEnhancements') ].
	
	spec for: #GToolkit do: [ 
		spec group: 'default' with: #('PharoEnhancements' 'PharoEnhancements-GToolkit' 'PharoWiki') ]
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
