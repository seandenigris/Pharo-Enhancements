Extension { #name : #SystemResolver }

{ #category : #'*PharoEnhancements' }
SystemResolver >> dynabookData [ 
	<origin>
	^ (FileLocator home / 'Dynabook' / 'User Data') resolve
]
