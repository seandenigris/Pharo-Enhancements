"
I resolve user-defined origins. To make your origin available, simply implement an instance-side method on me with a <supportedOrigin> annotation.

Example:
```
myLibraryData
	<supportedOrigin>
	
	^ '/path/to/library/data' asFileReference
```
"
Class {
	#name : #PeDynamicFSResolver,
	#superclass : #FileSystemResolver,
	#category : #'PharoEnhancements-Core'
}

{ #category : #'class initialization' }
PeDynamicFSResolver class >> initialize [
	SessionManager default registerSystemClassNamed: self name atPriority: 100. "After FileLocator"
	self startUp: true
]

{ #category : #'system startup' }
PeDynamicFSResolver class >> startUp: resuming [

	resuming ifFalse: [ ^ self ].
	
	FileLocator addResolver: self new
]

{ #category : #origins }
PeDynamicFSResolver >> dynabookData [
	<supportedOrigin>
	
	^ (FileLocator home / 'Dynabook' / 'User Data') resolve
]

{ #category : #resolving }
PeDynamicFSResolver >> supportedOrigins [
	"See class comment"

	| originPragmas selectors |
	originPragmas := Pragma allNamed: #supportedOrigin from: self class to: Object.	
	selectors := originPragmas collect: [ :each | each method selector ].
	^ Set withAll: selectors
]
