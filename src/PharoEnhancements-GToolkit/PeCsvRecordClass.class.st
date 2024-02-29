Class {
	#name : #PeCsvRecordClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'category'
	],
	#category : #'PharoEnhancements-GToolkit-CSV'
}

{ #category : #'private-generating' }
PeCsvRecordClass >> describe: field [
	| selector source |
	selector := field uncapitalized.
	selector := UIManager default
		request: 'selector'
		initialAnswer: selector.
	selector ifNil: [ ^ self ].
	source := self descriptionSourceTemplate format: { 
	#selector -> selector.
	#label -> selector normalizeCamelCase capitalized.
	#field -> field } asDictionary.
	self recordClass compile: source
]

{ #category : #'private-generating' }
PeCsvRecordClass >> descriptionSourceTemplate [
	^ '{selector}Description
	<magritteDescription>

	^ MADescription new
			accessor: #{selector};
			label: ''{label}'';
			propertyAt: #field put: ''{field}'';
			yourself'
]

{ #category : #generating }
PeCsvRecordClass >> ensureDescriptionsForFieldsFrom: csvFile [
	| describedFields newFields |
	describedFields := self recordClass new magritteDescription children
		collect: [ :e | e propertyAt: #field ].
	newFields := csvFile headers reject: [ :e | describedFields includes: e ].
	newFields do: [ :e | self describe: e ]
]

{ #category : #generating }
PeCsvRecordClass >> ensureFieldsDescribed [
	| describedFields newFields |
	describedFields := self recordClass new magritteDescription children
		collect: [ :e | e propertyAt: #field ].
	newFields := self headers reject: [ :e | describedFields includes: e ].
	newFields do: [ :e | self describe: e ]
]

{ #category : #'generating record class' }
PeCsvRecordClass >> generateInstVars [
	self recordClass new magritteDescription children
		do: [ :e | 
			| instVar r |
			instVar := e accessor selector asSymbol.
			self recordClass addInstVarNamed: instVar.
			r := RBCreateAccessorsForVariableRefactoring
				variable: instVar
				class: self recordClass
				classVariable: false.
			r execute ]
]

{ #category : #generating }
PeCsvRecordClass >> generateInstVarsFromDescriptions [
	self recordClass new magritteDescription children
		do: [ :e | 
			| instVar r |
			instVar := e accessor selector asSymbol.
			self recordClass addInstVarNamed: instVar.
			r := RBCreateAccessorsForVariableRefactoring
				variable: instVar
				class: self recordClass
				classVariable: false.
			r execute ]
]

{ #category : #'private-generating' }
PeCsvRecordClass >> recordClass [
	| existingClass |
	existingClass := Smalltalk classNamed: self name.
	^ existingClass ifNil: [ 
		self flag: 'In what case could a class not exist with the name of the current class?!'.
		Object subclass: self name
			instanceVariableNames: ''
			classVariableNames: ''
			package: self category ]
				
]
