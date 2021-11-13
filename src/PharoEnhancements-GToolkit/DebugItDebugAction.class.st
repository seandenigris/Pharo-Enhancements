Class {
	#name : #DebugItDebugAction,
	#superclass : #DebugAction,
	#category : 'PharoEnhancements-GToolkit-Actions'
}

{ #category : #registration }
DebugItDebugAction class >> actionType [
	"<debuggingAction>
	<contextMenuDebuggingAction>"
]

{ #category : #accessing }
DebugItDebugAction >> defaultKeymap [

	^ PharoShortcuts current debugItShortcut
]

{ #category : #accessing }
DebugItDebugAction >> defaultLabel [

	^ 'Debug'
]

{ #category : #accessing }
DebugItDebugAction >> defaultOrder [

	^ 9
]

{ #category : #actions }
DebugItDebugAction >> executeAction [

	| d interval |
	d := self debugger.
	interval := self session pcRangeForContext: d context.
	d playSelectionOrMethodFrom: d
	"self session restart: self currentContext"
]

{ #category : #accessing }
DebugItDebugAction >> help [
	^ 'Go back the start of the current execution context, resetting all local variables and take debugger control.'
]

{ #category : #accessing }
DebugItDebugAction >> id [

	^ #debugIt
]
