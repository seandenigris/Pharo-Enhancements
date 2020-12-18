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
