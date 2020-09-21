Extension { #name : #SmaCCParser }

{ #category : #'*PharoEnhancements-GToolkit' }
SmaCCParser class >> exampleNewEmptyParser [
	<gtExample>
	SmaCCParser
		newSubclassNamed: 'MyCoolParser'
		andScannerClassNamed: 'MyCoolScanner'
		inPackageNamed: 'MyCoolParser'.

	self assert: (Smalltalk globals hasClassNamed: #MyCoolParser).
	self assert: (Smalltalk globals hasClassNamed: #MyCoolScanner).
	self assert: (RPackageOrganizer default includesPackageNamed: #MyCoolParser).
	
	Smalltalk globals removeClassNamed: #MyCoolParser.
	Smalltalk globals removeClassNamed: #MyCoolScanner.
	RPackageOrganizer default unregisterPackageNamed: #MyCoolParser.
]

{ #category : #'*PharoEnhancements-GToolkit' }
SmaCCParser class >> newSubclassNamed: parserName andScannerClassNamed: scannerName inPackageNamed: packageName [
	| parserClass |
	parserClass := self
		subclass: parserName asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: packageName.
	SmaCCScanner
		subclass: scannerName asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: packageName.
	parserClass class
		compile: 'scannerClass
	^ ' , scannerName
		classified: 'generated-accessing'.
	parserClass class
		compile:
			'definitionComment
""'
		classified: 'generated'.
	^ parserClass
]
