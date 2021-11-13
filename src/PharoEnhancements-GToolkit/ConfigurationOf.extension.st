Extension { #name : #ConfigurationOf }

{ #category : #'*PharoEnhancements-GToolkit' }
ConfigurationOf class >> paintPackagesMapWith: mondrian [
	| packages projects |
	packages := self project version packages.
	projects := self project version projects.
	mondrian nodes 
		stencil: [ :packageSpec |
			| element |
			element := BlTextElement new.
			element
				when: BlClickEvent do: [ :e | 
					| toSpawn |
					toSpawn := RPackage organizer 
						packageNamed: packageSpec name 
						ifAbsent: [ packageSpec ].
					e consumed: true.
					element phlow spawnObject: toSpawn ];
				text: packageSpec name asRopedText ];
		with: packages.
	mondrian nodes 
		stencil: [ :projectSpec |
			| element |
			element := BlTextElement new.
			element 
				when: BlClickEvent do: [ :e | 
					| toSpawn |
					toSpawn := Smalltalk globals 
						at: projectSpec constructClassName asSymbol
						ifAbsent: [ projectSpec ].
					e consumed: true. 
					element phlow spawnObject: toSpawn ];
				text: (projectSpec name asRopedText foreground: Color gray) ];
		with: projects.
	packages do: [ :p | 
		mondrian edges
			stencil: [ :x | 
				BlParabollaArcElement new 
					zIndex: 0;
					curvatureFraction: 0.2;
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
					toHead: (BlArrowheadSimpleArrow new
						border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build)) ]; 
			fromRightCenter;
			toLeftCenter;
			connect: (p requires collect: [ :symbol | 
				packages 
					detect: [:package | package name = symbol ]
					ifNone: [ projects detect: [ :project | project name = symbol ] ] ])
			from:	[ :x | p ]
			to: #yourself ].
	mondrian layout horizontalDominanceTree nodeDistance: 10; levelDistance: 20
]
