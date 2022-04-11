Extension { #name : #PBObject }

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __annotations__ [
	"A dictionary or other mapping object used to store an object’s (writable) attributes. https://docs.python.org/3/library/stdtypes.html"
	^ self getAttribute: #__annotations__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __class__ [
	"A dictionary or other mapping object used to store an object’s (writable) attributes. https://docs.python.org/3/library/stdtypes.html"
	^ self getAttribute: #__class__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __closure__ [
	"The function’s documentation string, or None if unavailable; not inherited by subclasses.
	
	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__closure__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __code__ [
	"The code object representing the compiled function body.

	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__code__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __defaults__ [
	"A tuple containing default argument values for those arguments that have defaults, or None if no arguments have a default value. https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__defaults__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __dict__ [
	"A dictionary or other mapping object used to store an object’s (writable) attributes. https://docs.python.org/3/library/stdtypes.html"
	^ self getAttribute: #__dict__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __doc__ [
	"The function’s documentation string, or None if unavailable; not inherited by subclasses.
	
	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__doc__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __module__ [
	"The name of the module the function was defined in, or None if unavailable.

	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__module__ 
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __name__ [
	^ [ self getAttribute: #__name__ ]
		on: PBPythonError
		do: [ nil ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> __qualname__ [
	"The qualified name of the class, function, method, descriptor, or generator instance. 
	New in version 3.3.

	Reference: https://docs.python.org/3/library/stdtypes.html#definition.__qualname__"
	^ [ self getAttribute: #__qualname__ ]
		on: PBPythonError
		do: [ nil ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> codeAttribute [
	"The code object representing the compiled function body.

	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__code__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> defaultsAttribute [
	"A tuple containing default argument values for those arguments that have defaults, or None if no arguments have a default value.

	Reference: https://docs.python.org/3/reference/datamodel.html#objects"
	^ self getAttribute: #__defaults__
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> dir [
	^ self newCommandFactory
		<< (#dir asP3GI callWith: { self });
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> getAttribute: aSymbol [
	^ self newCommandFactory
		<< (self => aSymbol);
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> gtDictFor: aView [
	<gtView>
	
	^ aView forward
		title: 'dict';
		priority: 25;
		object: [ self __dict__ ];
		view: #gtItemsFor:
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> gtDirFor: aView [
	<gtView>
	
	^ aView list
		title: 'dir()';
		priority: 50;
		items: [ self dir ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> gtDocFor: aView [
	<gtView>
	
	| doc |
	doc := self __doc__.
	doc ifEmpty: [ ^ aView empty ].
	^ aView text
		title: 'Doc';
		priority: 12;
		text: doc
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> gtPyPrintFor: aView [
	<gtView>
	
	^ aView text
		title: 'PyPrint';
		priority: 37;
		text: [ self str, ' (Str~#displayString)', Character cr asString,
			self repr, ' (Repr~#printString)' ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> pythonID [
	^ self newCommandFactory
		<< (#id asP3GI callWith: { self });
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> repr [
	"Python equivalent of #printString per https://medium.com/swlh/string-representations-in-python-understand-repr-vs-str-12f046986eb5"
	^ self newCommandFactory
		<< (#repr asP3GI callWith: { self });
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> send: aSelector [
	^ self send: aSelector positionalArguments: nil keywordArguments: nil
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> send: aSelector positionalArguments: positionalArgs [
	^ self send: aSelector positionalArguments: positionalArgs keywordArguments: nil
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> send: aSelector positionalArguments: positionalArgs keywordArguments: keywordArgs [
	self flag: 'should get factory from self, but for https://github.com/feenkcom/gtoolkit/issues/2407'.
	^ PBApplication uniqueInstance newCommandFactory
		<< (P3GCall target: self => aSelector  positionalArguments: positionalArgs keywordArguments: keywordArgs);
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> str [
	"Python equivalent of #displayString per https://medium.com/swlh/string-representations-in-python-understand-repr-vs-str-12f046986eb5"
	^ self newCommandFactory
		<< (#str asP3GI callWith: { self });
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> type [
	^ self newCommandFactory
		<< (#type asP3GI callWith: { self });
		sendAndWait
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBObject >> vars [
	^ self newCommandFactory
		<< (#vars asP3GI callWith: { self });
		sendAndWait
]
