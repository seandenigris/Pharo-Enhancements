Class {
	#name : #HtmlLink,
	#superclass : #Object,
	#instVars : [
		'destination',
		'text'
	],
	#category : 'PharoEnhancements'
}

{ #category : #example }
HtmlLink class >> example [
	<sampleInstance>
	^ self new
			destination: 'http://www.pharo.org';
			text: 'Pharo Website';
			yourself
]

{ #category : #example }
HtmlLink class >> exampleClip [
	<sampleInstance>
	^ self
		given: [ self example ]
		when: [ :link | link clip ]
		then: [ :link | 
			"Test should be:
				Clipboard clipboardText asString should equal: link printString
			But couldn't find a way to get the RTF back in Pharo" ]
]

{ #category : #comparing }
HtmlLink >> = rhs [
	^ self destination = rhs destination and: [ self text = rhs text ]
]

{ #category : #printing }
HtmlLink >> clip [
	| tempFile command |
	[ 
		tempFile := FileReference newTempFilePrefix: 'htmllink' suffix: 'txt'.
		tempFile writeStreamDo: [ :s | s nextPutAll: self asString ].
		command := '/usr/bin/textutil -format html -convert rtf -stdout ' , (tempFile fullName surroundedBy: '"') , ' | /usr/bin/pbcopy'.
		LibC system: command
	] ensure: [ "tempFile delete" ]

	"Implementation note: the first attempt was to pass the input via a HEREDOC, but that didn't seem to work with LibC"
]

{ #category : #accessing }
HtmlLink >> destination [
	^ destination
]

{ #category : #accessing }
HtmlLink >> destination: anObject [
	destination := anObject
]

{ #category : #comparing }
HtmlLink >> hash [
	^ self destination hash bitXor: self text
]

{ #category : #printing }
HtmlLink >> printOn: aStream [
	| template string |
	template := '<a href="{url}">{title}</a>'.
	string := template format: { 
		#url -> self destination asString.
		#title -> self text } asDictionary.
	aStream nextPutAll: string
]

{ #category : #accessing }
HtmlLink >> text [
	^ text
]

{ #category : #accessing }
HtmlLink >> text: anObject [
	text := anObject
]
