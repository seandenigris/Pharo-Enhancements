*PharoEnhancements
isMD5Equal: aReference
	| sourceHash targetHash |
	sourceHash := self binaryReadStreamDo: [ :str | MD5 hashStream: str ].
	targetHash := aReference binaryReadStreamDo: [ :str | MD5 hashStream: str ].
	^ sourceHash = targetHash