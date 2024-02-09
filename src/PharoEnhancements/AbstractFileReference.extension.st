Extension { #name : #AbstractFileReference }

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> macLock: aBoolean [
	"Adapted from https://macosx.com/threads/lock-unlock-files-with-the-terminal.317350/"
	| keyword commandTemplate command |
	OSPlatform current isMacOSX ifFalse: [ ^ self ].
	keyword := aBoolean
		ifTrue: [ 'uchg' ]
		ifFalse: [ 'nouchg' ].
	commandTemplate := 'chflags {keyword} "{fileName}"'.
	command := commandTemplate format: { 
		#keyword -> keyword.
		#fileName -> self fullName } asDictionary.
	LibC system: command
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> peOpen [
	LibC system: 'open "', self fullName, '"'
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> preview [
	self quickLook
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> quickLook [
				
	"Reference: http://www.maclife.com/article/columns/easy_mac_hacks_using_quicklook_command_line"
	LibC system: '/usr/bin/qlmanage -p "', self quickLookInputFile fullName, '" &'
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> quickLookInputFile [
	
	| isEmail |
	
	"EML files may not have the right line endings to be displayed properly by quick look. See https://www.karma.net/2020/10/26/quicklook-eml-catalina"
	isEmail := #('eml'" 'emlx'") includes: self extension.
	
	^ isEmail
		ifFalse: [ self ]
		ifTrue: [ 
			| tempfile |
			tempfile := FileLocator temp / DateAndTime now asString asFilename, self extension.
			tempfile 
				writeStreamDo: [ :str | str << self contents withUnixLineEndings ];
				yourself ].
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> showInFinder [
	LibC system: 'open --reveal ', (self fullName surroundedBy: '"')
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> thumbnail [
				
	"Reference: "
	| result |
	result := Tempfile rootFolder / self basename, 'png'.
	LibC system: '/usr/bin/qlmanage -t ', self quickLookInputFile fullName surroundedByDoubleQuotes, ' -s 2048 -o ', result parent fullName surroundedByDoubleQuotes.
	^ result
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> verifiedCopyTo: aReference [
	| result |
	result := self copyTo: aReference.
	(self isMD5Equal: aReference) ifFalse: [ self error: 'Copy hash has changed!' ].
	^ result
]

{ #category : #'*PharoEnhancements' }
AbstractFileReference >> verifiedMoveTo: aFileReference [
	self verifiedCopyTo: aFileReference.
	self delete
]
