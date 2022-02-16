Class {
	#name : #PeTOMLScanner,
	#superclass : #SmaCCScanner,
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #'generated-initialization' }
PeTOMLScanner class >> initializeKeywordMap [

	keywordMap := Dictionary new.
	#( #( 27 'false' 11 ) #( 27 'true' 11 ) ) do: [ :each | 
		(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
			at: (each at: 2)
			put: each last ].
	^ keywordMap
]

{ #category : #generated }
PeTOMLScanner >> emptySymbolTokenId [

	^ 62
]

{ #category : #generated }
PeTOMLScanner >> errorTokenId [

	^ 63
]

{ #category : #generated }
PeTOMLScanner >> scan1 [

	[ 
	self recordMatch: #( 8 9 ).
	self step.
	currentCharacter == Character lf ] whileTrue.
	currentCharacter == Character cr ifTrue: [ ^ self scan2 ].
	(currentCharacter isSeparator or: [ 
		 currentCharacter == Character pageUp ]) ifTrue: [ 
		[ 
		self recordMatch: #( 8 ).
		self step.
		currentCharacter isSeparator or: [ 
			currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan10 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan12 ].
	('+-' includes: currentCharacter) ifTrue: [ ^ self scan11 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan11 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan12 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan12 [

	[ 
	self recordMatch: #( 16 ).
	self step.
	currentCharacter == $_ ifTrue: [ ^ self scan11 ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan13 [

	[ 
	self recordMatch: #( 19 ).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ 
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan13 ].
		^ self reportLastMatch ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan14 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $+ ifTrue: [ ^ self scan11 ].
	currentCharacter == $- ifTrue: [ ^ self scan15 ].
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan16 ].
	((currentCharacter between: $A and: $Z) or: [ 
		 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan15 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan16 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan16 [

	[ 
	self recordMatch: #( 16 27 ).
	self step.
	currentCharacter == $_ ifTrue: [ ^ self scan15 ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter between: $a and: $z ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan17 [

	[ 
	self recordMatch: #( 19 27 ).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ ^ self scan18 ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $D) or: [ 
			 (currentCharacter between: $F and: $Z) or: [ 
				 (currentCharacter between: $a and: $d) or: [ 
					 currentCharacter between: $f and: $z ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan18 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan17 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan19 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $n ifTrue: [ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $f ifTrue: [ 
			self recordMatch: #( 17 27 ).
			self step.
			(currentCharacter == $- or: [ 
				 (currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $Z) or: [ 
						 currentCharacter == $_ or: [ 
							 currentCharacter between: $a and: $z ] ] ] ]) ifTrue: [ 
				[ 
				self recordMatch: #( 27 ).
				self step.
				currentCharacter == $- or: [ 
					(currentCharacter between: $0 and: $9) or: [ 
						(currentCharacter between: $A and: $Z) or: [ 
							currentCharacter == $_ or: [ 
								currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
			^ self reportLastMatch ].
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $Z) or: [ 
					 currentCharacter == $_ or: [ 
						 (currentCharacter between: $a and: $e) or: [ 
							 currentCharacter between: $g and: $z ] ] ] ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $Z) or: [ 
				 currentCharacter == $_ or: [ 
					 (currentCharacter between: $a and: $m) or: [ 
						 currentCharacter between: $o and: $z ] ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan2 [

	self recordMatch: #( 8 ).
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan1 ].
	(currentCharacter isSeparator or: [ 
		 currentCharacter == Character pageUp ]) ifTrue: [ 
		[ 
		self recordMatch: #( 8 ).
		self step.
		currentCharacter isSeparator or: [ 
			currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan20 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $a ifTrue: [ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $n ifTrue: [ 
			self recordMatch: #( 18 27 ).
			self step.
			(currentCharacter == $- or: [ 
				 (currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $Z) or: [ 
						 currentCharacter == $_ or: [ 
							 currentCharacter between: $a and: $z ] ] ] ]) ifTrue: [ 
				[ 
				self recordMatch: #( 27 ).
				self step.
				currentCharacter == $- or: [ 
					(currentCharacter between: $0 and: $9) or: [ 
						(currentCharacter between: $A and: $Z) or: [ 
							currentCharacter == $_ or: [ 
								currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
			^ self reportLastMatch ].
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $Z) or: [ 
					 currentCharacter == $_ or: [ 
						 (currentCharacter between: $a and: $m) or: [ 
							 currentCharacter between: $o and: $z ] ] ] ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $Z) or: [ 
				 currentCharacter == $_ or: [ 
					 currentCharacter between: $b and: $z ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan21 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan22 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan22 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan23 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan23 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $- ifTrue: [ 
		self recordMatch: #( 27 ).
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self recordMatch: #( 27 ).
			self step.
			(currentCharacter between: $0 and: $9) ifTrue: [ 
				self recordMatch: #( 25 27 ).
				self step.
				currentCharacter == Character space ifTrue: [ 
					self step.
					(currentCharacter between: $0 and: $9) ifTrue: [ 
						self step.
						(currentCharacter between: $0 and: $9) ifTrue: [ 
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan24 ] ] ].
					^ self reportLastMatch ].
				('Tt' includes: currentCharacter) ifTrue: [ 
					self recordMatch: #( 27 ).
					self step.
					(currentCharacter between: $0 and: $9) ifTrue: [ 
						self recordMatch: #( 27 ).
						self step.
						(currentCharacter between: $0 and: $9) ifTrue: [ 
							self recordMatch: #( 27 ).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan24 ].
							(currentCharacter == $- or: [ 
								 (currentCharacter between: $0 and: $9) or: [ 
									 (currentCharacter between: $A and: $Z) or: [ 
										 currentCharacter == $_ or: [ 
											 currentCharacter between: $a and: $z ] ] ] ]) ifTrue: [ 
								[ 
								self recordMatch: #( 27 ).
								self step.
								currentCharacter == $- or: [ 
									(currentCharacter between: $0 and: $9) or: [ 
										(currentCharacter between: $A and: $Z) or: [ 
											currentCharacter == $_ or: [ 
												currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
							^ self reportLastMatch ] ].
					(currentCharacter == $- or: [ 
						 (currentCharacter between: $A and: $Z) or: [ 
							 currentCharacter == $_ or: [ 
								 currentCharacter between: $a and: $z ] ] ]) ifTrue: [ 
						[ 
						self recordMatch: #( 27 ).
						self step.
						currentCharacter == $- or: [ 
							(currentCharacter between: $0 and: $9) or: [ 
								(currentCharacter between: $A and: $Z) or: [ 
									currentCharacter == $_ or: [ 
										currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
					^ self reportLastMatch ].
				(currentCharacter == $- or: [ 
					 (currentCharacter between: $0 and: $9) or: [ 
						 (currentCharacter between: $A and: $S) or: [ 
							 (currentCharacter between: $U and: $Z) or: [ 
								 currentCharacter == $_ or: [ 
									 (currentCharacter between: $a and: $s) or: [ 
										 currentCharacter between: $u and: $z ] ] ] ] ] ]) ifTrue: [ 
					[ 
					self recordMatch: #( 27 ).
					self step.
					currentCharacter == $- or: [ 
						(currentCharacter between: $0 and: $9) or: [ 
							(currentCharacter between: $A and: $Z) or: [ 
								currentCharacter == $_ or: [ 
									currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
				^ self reportLastMatch ] ].
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $A and: $Z) or: [ 
				 currentCharacter == $_ or: [ 
					 currentCharacter between: $a and: $z ] ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	((currentCharacter between: $0 and: $9) or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan24 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self step.
			currentCharacter == $: ifTrue: [ 
				self step.
				(currentCharacter between: $0 and: $9) ifTrue: [ 
					self step.
					(currentCharacter between: $0 and: $9) ifTrue: [ 
						self recordMatch: #( 24 ).
						self step.
						currentCharacter == $. ifTrue: [ 
							self step.
							(currentCharacter between: $0 and: $9) ifTrue: [ 
								[ 
								self recordMatch: #( 24 ).
								self step.
								currentCharacter == $Z ifTrue: [ 
									^ self recordAndReportMatch: #( 23 ) ].
								currentCharacter between: $0 and: $9 ] whileTrue.
								('+-' includes: currentCharacter) ifTrue: [ ^ self scan25 ] ].
							^ self reportLastMatch ].
						currentCharacter == $Z ifTrue: [ 
							^ self recordAndReportMatch: #( 23 ) ].
						('+-' includes: currentCharacter) ifTrue: [ ^ self scan25 ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan25 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self step.
			currentCharacter == $: ifTrue: [ 
				self step.
				(currentCharacter between: $0 and: $9) ifTrue: [ 
					self step.
					(currentCharacter between: $0 and: $9) ifTrue: [ 
						^ self recordAndReportMatch: #( 23 ) ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan26 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self step.
			currentCharacter == $: ifTrue: [ 
				self step.
				(currentCharacter between: $0 and: $9) ifTrue: [ 
					self step.
					(currentCharacter between: $0 and: $9) ifTrue: [ 
						self recordMatch: #( 26 ).
						self step.
						currentCharacter == $. ifTrue: [ 
							self step.
							(currentCharacter between: $0 and: $9) ifTrue: [ 
								[ 
								self recordMatch: #( 26 ).
								self step.
								currentCharacter between: $0 and: $9 ] whileTrue ] ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan27 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $1) ifTrue: [ 
		[ 
		self recordMatch: #( 22 27 ).
		self step.
		currentCharacter == $_ ifTrue: [ ^ self scan27 ].
		currentCharacter between: $0 and: $1 ] whileTrue.
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $2 and: $9) or: [ 
				 (currentCharacter between: $A and: $Z) or: [ 
					 currentCharacter between: $a and: $z ] ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $2 and: $9) or: [ 
			 (currentCharacter between: $A and: $Z) or: [ 
				 currentCharacter == $_ or: [ 
					 currentCharacter between: $a and: $z ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan28 [

	self recordMatch: #( 27 ).
	self step.
	(currentCharacter between: $0 and: $7) ifTrue: [ 
		[ 
		self recordMatch: #( 21 27 ).
		self step.
		currentCharacter == $_ ifTrue: [ ^ self scan28 ].
		currentCharacter between: $0 and: $7 ] whileTrue.
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $8 and: $9) or: [ 
				 (currentCharacter between: $A and: $Z) or: [ 
					 currentCharacter between: $a and: $z ] ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $8 and: $9) or: [ 
			 (currentCharacter between: $A and: $Z) or: [ 
				 currentCharacter == $_ or: [ 
					 currentCharacter between: $a and: $z ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan29 [

	self recordMatch: #( 27 ).
	self step.
	((currentCharacter between: $0 and: $9) or: [ 
		 (currentCharacter between: $A and: $F) or: [ 
			 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 20 27 ).
		self step.
		currentCharacter == $_ ifTrue: [ ^ self scan29 ].
		(currentCharacter between: $0 and: $9) or: [ 
			(currentCharacter between: $A and: $F) or: [ 
				currentCharacter between: $a and: $f ] ] ] whileTrue.
		(currentCharacter == $- or: [ 
			 (currentCharacter between: $G and: $Z) or: [ 
				 currentCharacter between: $g and: $z ] ]) ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
		^ self reportLastMatch ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $G and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $g and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan3 [

	[ 
	self step.
	currentCharacter == $" ifTrue: [ 
		^ self recordAndReportMatch: #( 12 ) ].
	currentCharacter == $\ ifTrue: [ ^ self scan4 ].
	currentCharacter <= Character tab or: [ 
		(currentCharacter between: Character pageUp and: $!) or: [ 
			(currentCharacter between: $# and: $[) or: [ 
				currentCharacter >= $] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan4 [

	self step.
	currentCharacter == $U ifTrue: [ 
		self step.
		((currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $F) or: [ 
				 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
			self step.
			((currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $F) or: [ 
					 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
				self step.
				((currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $F) or: [ 
						 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
					self step.
					((currentCharacter between: $0 and: $9) or: [ 
						 (currentCharacter between: $A and: $F) or: [ 
							 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
						^ self scan5 ] ] ] ].
		^ self reportLastMatch ].
	currentCharacter == $u ifTrue: [ ^ self scan5 ].
	('"/\bfnrt' includes: currentCharacter) ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan5 [

	self step.
	((currentCharacter between: $0 and: $9) or: [ 
		 (currentCharacter between: $A and: $F) or: [ 
			 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
		self step.
		((currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $F) or: [ 
				 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
			self step.
			((currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $F) or: [ 
					 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
				self step.
				((currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $F) or: [ 
						 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
					^ self scan3 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan6 [

	[ 
	self step.
	currentCharacter == $" ifTrue: [ 
		(self scanForString: '""') ifTrue: [ 
			^ self recordAndReportMatch: #( 13 ) ].
		^ self reportLastMatch ].
	currentCharacter == $\ ifTrue: [ 
		self step.
		currentCharacter == Character cr ifTrue: [ 
			self step.
			currentCharacter == Character lf ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
		currentCharacter == $U ifTrue: [ 
			self step.
			((currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $F) or: [ 
					 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
				self step.
				((currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $F) or: [ 
						 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
					self step.
					((currentCharacter between: $0 and: $9) or: [ 
						 (currentCharacter between: $A and: $F) or: [ 
							 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
						self step.
						((currentCharacter between: $0 and: $9) or: [ 
							 (currentCharacter between: $A and: $F) or: [ 
								 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
							^ self scan7 ] ] ] ].
			^ self reportLastMatch ].
		currentCharacter == $u ifTrue: [ ^ self scan7 ].
		(currentCharacter == Character lf or: [ 
			 '"/\bfnrt' includes: currentCharacter ]) ifTrue: [ ^ self scan6 ].
		^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
PeTOMLScanner >> scan7 [

	self step.
	((currentCharacter between: $0 and: $9) or: [ 
		 (currentCharacter between: $A and: $F) or: [ 
			 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
		self step.
		((currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $F) or: [ 
				 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
			self step.
			((currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $F) or: [ 
					 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
				self step.
				((currentCharacter between: $0 and: $9) or: [ 
					 (currentCharacter between: $A and: $F) or: [ 
						 currentCharacter between: $a and: $f ] ]) ifTrue: [ 
					^ self scan6 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scan8 [

	[ 
	self step.
	currentCharacter == $' ifTrue: [ 
		(self scanForString: '''''') ifTrue: [ 
			[ 
			self recordMatch: #( 15 ).
			self step.
			currentCharacter == $' ] whileTrue ].
		^ self scan8 ].
	true ] whileTrue
]

{ #category : #generated }
PeTOMLScanner >> scan9 [

	self step.
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		[ 
		self recordMatch: #( 16 ).
		self step.
		currentCharacter == $_ ifTrue: [ ^ self scan9 ].
		currentCharacter between: $0 and: $9 ] whileTrue.
		('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForToken [

	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan1 ].
	currentCharacter == Character cr ifTrue: [ ^ self scan2 ].
	^ self scanForTokenX11
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX1 [

	self recordMatch: #( 19 27 ).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $b ifTrue: [ ^ self scan27 ].
	currentCharacter == $o ifTrue: [ ^ self scan28 ].
	^ self scanForTokenX1X3
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX10 [

	currentCharacter == $n ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #( 6 ) ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #( 7 ) ].
	(currentCharacter between: $1 and: $9) ifTrue: [ 
		^ self scanForTokenX3 ].
	(currentCharacter isSeparator or: [ 
		 currentCharacter == Character pageUp ]) ifTrue: [ 
		^ self scanForTokenX9 ].
	((currentCharacter between: $A and: $Z) or: [ 
		 currentCharacter == $_ or: [ 
			 (currentCharacter between: $a and: $h) or: [ 
				 (currentCharacter between: $j and: $m) or: [ 
					 currentCharacter between: $o and: $z ] ] ] ]) ifTrue: [ 
		self scanForTokenX7 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX11 [

	currentCharacter == $" ifTrue: [ ^ self scanForTokenX5 ].
	currentCharacter == $# ifTrue: [ ^ self scanForTokenX8 ].
	currentCharacter == $' ifTrue: [ ^ self scanForTokenX6 ].
	currentCharacter == $+ ifTrue: [ ^ self scanForTokenX4 ].
	currentCharacter == $, ifTrue: [ ^ self recordAndReportMatch: #( 1 ) ].
	currentCharacter == $- ifTrue: [ ^ self scanForTokenX2 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #( 2 ) ].
	currentCharacter == $0 ifTrue: [ ^ self scanForTokenX1 ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #( 3 ) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #( 4 ) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #( 5 ) ].
	currentCharacter == $i ifTrue: [ ^ self scan19 ].
	^ self scanForTokenX10
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX1X1 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan26 ].
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		self recordMatch: #( 27 ).
		self step.
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- ifTrue: [ ^ self scan21 ].
			((currentCharacter between: $0 and: $9) or: [ 
				 (currentCharacter between: $A and: $Z) or: [ 
					 currentCharacter == $_ or: [ 
						 currentCharacter between: $a and: $z ] ] ]) ifTrue: [ 
				[ 
				self recordMatch: #( 27 ).
				self step.
				currentCharacter == $- or: [ 
					(currentCharacter between: $0 and: $9) or: [ 
						(currentCharacter between: $A and: $Z) or: [ 
							currentCharacter == $_ or: [ 
								currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
			^ self reportLastMatch ] ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ]) 
		ifTrue: [ 
			[ 
			self recordMatch: #( 27 ).
			self step.
			currentCharacter == $- or: [ 
				(currentCharacter between: $0 and: $9) or: [ 
					(currentCharacter between: $A and: $Z) or: [ 
						currentCharacter == $_ or: [ 
							currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX1X2 [

	[ 
	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $- or: [ 
		(currentCharacter between: $0 and: $9) or: [ 
			(currentCharacter between: $A and: $Z) or: [ 
				currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX1X3 [

	currentCharacter == $x ifTrue: [ ^ self scan29 ].
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		^ self scanForTokenX1X1 ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $D) or: [ 
			 (currentCharacter between: $F and: $Z) or: [ 
				 ('_a' includes: currentCharacter) or: [ 
					 (currentCharacter between: $c and: $d) or: [ 
						 (currentCharacter between: $f and: $n) or: [ 
							 (currentCharacter between: $p and: $w) or: [ 
								 currentCharacter between: $y and: $z ] ] ] ] ] ] ]) ifTrue: [ 
		self scanForTokenX1X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX2 [

	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $0 ifTrue: [ ^ self scanForTokenX2X1 ].
	currentCharacter == $i ifTrue: [ ^ self scan19 ].
	currentCharacter == $n ifTrue: [ ^ self scan20 ].
	(currentCharacter between: $1 and: $9) ifTrue: [ ^ self scan17 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $Z) or: [ 
			 currentCharacter == $_ or: [ 
				 (currentCharacter between: $a and: $h) or: [ 
					 (currentCharacter between: $j and: $m) or: [ 
						 currentCharacter between: $o and: $z ] ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX2X1 [

	self recordMatch: #( 19 27 ).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $0 and: $9) or: [ 
			 (currentCharacter between: $A and: $D) or: [ 
				 (currentCharacter between: $F and: $Z) or: [ 
					 currentCharacter == $_ or: [ 
						 (currentCharacter between: $a and: $d) or: [ 
							 currentCharacter between: $f and: $z ] ] ] ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX3 [

	self recordMatch: #( 19 27 ).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ ^ self scan18 ].
	(currentCharacter between: $0 and: $9) ifTrue: [ 
		self recordMatch: #( 19 27 ).
		self step.
		currentCharacter == $. ifTrue: [ ^ self scan9 ].
		currentCharacter == $: ifTrue: [ ^ self scan26 ].
		currentCharacter == $_ ifTrue: [ ^ self scan18 ].
		(currentCharacter between: $0 and: $9) ifTrue: [ 
			self recordMatch: #( 19 27 ).
			self step.
			currentCharacter == $. ifTrue: [ ^ self scan9 ].
			currentCharacter == $_ ifTrue: [ ^ self scan18 ].
			(currentCharacter between: $0 and: $9) ifTrue: [ 
				^ self scanForTokenX3X1 ] ] ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	(currentCharacter == $- or: [ 
		 (currentCharacter between: $A and: $D) or: [ 
			 (currentCharacter between: $F and: $Z) or: [ 
				 (currentCharacter between: $a and: $d) or: [ 
					 currentCharacter between: $f and: $z ] ] ] ]) ifTrue: [ 
		self scanForTokenX3X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX3X1 [

	self recordMatch: #( 19 27 ).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan21 ].
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ ^ self scan18 ].
	(currentCharacter between: $0 and: $9) ifTrue: [ ^ self scan17 ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	((currentCharacter between: $A and: $D) or: [ 
		 (currentCharacter between: $F and: $Z) or: [ 
			 (currentCharacter between: $a and: $d) or: [ 
				 currentCharacter between: $f and: $z ] ] ]) ifTrue: [ 
		[ 
		self recordMatch: #( 27 ).
		self step.
		currentCharacter == $- or: [ 
			(currentCharacter between: $0 and: $9) or: [ 
				(currentCharacter between: $A and: $Z) or: [ 
					currentCharacter == $_ or: [ 
						currentCharacter between: $a and: $z ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX3X2 [

	[ 
	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $- or: [ 
		(currentCharacter between: $0 and: $9) or: [ 
			(currentCharacter between: $A and: $Z) or: [ 
				currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX4 [

	self step.
	currentCharacter == $0 ifTrue: [ 
		self recordMatch: #( 19 ).
		self step.
		currentCharacter == $. ifTrue: [ ^ self scan9 ].
		('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ].
		^ self reportLastMatch ].
	currentCharacter == $i ifTrue: [ 
		(self scanForString: 'nf') ifTrue: [ 
			^ self recordAndReportMatch: #( 17 ) ].
		^ self reportLastMatch ].
	currentCharacter == $n ifTrue: [ 
		(self scanForString: 'an') ifTrue: [ 
			^ self recordAndReportMatch: #( 18 ) ].
		^ self reportLastMatch ].
	(currentCharacter between: $1 and: $9) ifTrue: [ ^ self scan13 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX5 [

	self step.
	currentCharacter == $" ifTrue: [ 
		self recordMatch: #( 12 ).
		self step.
		currentCharacter == $" ifTrue: [ ^ self scan6 ].
		^ self reportLastMatch ].
	currentCharacter == $\ ifTrue: [ ^ self scan4 ].
	(currentCharacter <= Character tab or: [ 
		 (currentCharacter between: Character pageUp and: $!) or: [ 
			 (currentCharacter between: $# and: $[) or: [ 
				 currentCharacter >= $] ] ] ]) ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX6 [

	self step.
	currentCharacter == $' ifTrue: [ 
		self recordMatch: #( 14 ).
		self step.
		currentCharacter == $' ifTrue: [ ^ self scan8 ].
		^ self reportLastMatch ].
	(currentCharacter <= Character tab or: [ 
		 (currentCharacter between: Character pageUp and: $&) or: [ 
			 currentCharacter >= $( ] ]) ifTrue: [ 
		[ 
		self step.
		currentCharacter == $' ifTrue: [ 
			^ self recordAndReportMatch: #( 14 ) ].
		currentCharacter <= Character tab or: [ 
			(currentCharacter between: Character pageUp and: $&) or: [ 
				currentCharacter >= $( ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX7 [

	[ 
	self recordMatch: #( 27 ).
	self step.
	currentCharacter == $- or: [ 
		(currentCharacter between: $0 and: $9) or: [ 
			(currentCharacter between: $A and: $Z) or: [ 
				currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX8 [

	[ 
	self recordMatch: #( 10 ).
	self step.
	currentCharacter <= Character tab or: [ 
		(currentCharacter between: Character pageUp and: Character newPage) 
			or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> scanForTokenX9 [

	[ 
	self recordMatch: #( 8 ).
	self step.
	currentCharacter isSeparator or: [ 
		currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
PeTOMLScanner >> tokenActions [

	^ #( nil nil nil nil nil nil nil #whitespace )
]
