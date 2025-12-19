Extension { #name : 'ConfigurationOf' }

{ #category : '*PharoEnhancements' }
ConfigurationOf class >> createBaselineFrom: selector [

	| projectName baselineName baseline methodTree commonBlockBody |
	
	"Create new class"
	projectName := self name allButFirst: self superclass name size.
	baselineName := 'BaselineOf', projectName.
	baseline := BaselineOf subclass: baselineName asSymbol
	instanceVariableNames: ''
	classVariableNames: ''
	category: baselineName.
	
	"Convert baseline##: method"
	methodTree := (self methodNamed: selector) parseTree.
	methodTree selector: #baseline:.
	methodTree pragmas at: 1 put: (RBPragmaNode selector: #baseline arguments: #()).
	commonBlockBody := methodTree statements first arguments last body.
	commonBlockBody statements
		detect: [ :e | e selector = #repository: ]
		ifFound: [ :repoSetter | commonBlockBody removeNode: repoSetter ].
	
	"Compile baseline method"
	baseline compile: methodTree newSource classified: 'baseline'
]
