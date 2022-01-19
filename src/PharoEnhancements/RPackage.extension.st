Extension { #name : #RPackage }

{ #category : #'*PharoEnhancements' }
RPackage >> createBaselineOf [
	"Example:
		(RPackage named: 'MyCoolPackage') createBaselineOf
	"

	(MetacelloToolBox baselineNamed: self name)
		createBaselineOfMethod: 'baseline:' inCategory: 'baseline';
		addBaselineOfSection: #common
			requiredProjects: #() "This means Configs, not Baselines, so will usually be empty"
			packages: { self name }
			repositories: #()
			dependencies: #() "Could calculate from Dependency Analyzer?"
			groups: #()
			versionSpecsDo: [ :versionSpec |  ];
		commitBaselineOfMethod
]

{ #category : #'*PharoEnhancements' }
RPackage >> deprecate [
	self packageManifest class compile: 'isDeprecated
	^ true' classified: 'testing'
]

{ #category : #'*PharoEnhancements' }
RPackage >> gitHubUrl [

	| str |
	str := '{repoUrl}/blob/master/src/{package}/' 
		format: {
			#repoUrl -> (self peIceRepository origin httpsUrl allButLast: '.git' size).
			#package -> self name } asDictionary.
	^ str asUrl
]

{ #category : #'*PharoEnhancements' }
RPackage >> peIceRepository [
	"Unlike RPackage>>#iceRepository, I work with non-MC e.g. git"
	^ IceRepository registry detect: [ :e | e includesPackageNamed: self name ] ifNone: [ nil ].
]
