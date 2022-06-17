Class {
	#name : #PeCharacterDiff,
	#superclass : #Object,
	#instVars : [
		'characters'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeCharacterDiff class >> comparing: newString to: oldString [
	| diffString chars |
	diffString := PBApplication uniqueInstance newCommandStringFactory
    	addAllBindings: { 
        	#newString -> newString.
        	#oldString -> oldString } asDictionary;
	    script: 'import difflib
diff = difflib.ndiff(oldString,newString)';
	    resultExpression: '''''.join(diff)';
    	sendAndWait.
  chars := self ndiffParser parse: diffString.
	^ self new
		characters: chars;
		yourself
]

{ #category : #accessing }
PeCharacterDiff class >> example [
	<gtExample>
	
	^ self comparing: 'one' to: 'ore'
]

{ #category : #accessing }
PeCharacterDiff class >> ndiffParser [
	| char |
	char := (PP2PredicateObjectNode anyOf: ' -+'), #space asPParser, #any asPParser ==> [ :n |
		PeDiffCharacter new
			status: n first;
			character: n last;
			yourself ].
	^ char star
]

{ #category : #accessing }
PeCharacterDiff >> characters [

	^ characters ifNil: [ {} ]
]

{ #category : #accessing }
PeCharacterDiff >> characters: anObject [

	characters := anObject
]

{ #category : #accessing }
PeCharacterDiff >> gtViewTextFor: aView [
	<gtView>
	^ aView text
		title: 'Text';
		priority: 20;
		text: [ self text ]
]

{ #category : #accessing }
PeCharacterDiff >> text [
	| string text |
	string := String streamContents: [ :str |
	self characters do: [ :e |
		str << e character ] ].
	text := BlRunRopedText string: string.
	self characters doWithIndex: [ :e :i | 
		(text from: i to: i)
    		attributes: e textAttributes ].
	^ text
]
