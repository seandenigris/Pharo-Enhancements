Extension { #name : #PluggableTextFieldMorph }

{ #category : #'*PharoEnhancements' }
PluggableTextFieldMorph >> entryCompletion: anEntryCompletion [
	entryCompletion := anEntryCompletion.
	entryCompletion ifNotNil: [ 
		entryCompletion chooseBlock isNil
			ifTrue: [ entryCompletion
					chooseBlock: [ :v | 
						self setText: v.
						self acceptTextInModel ] ]
			ifFalse: [ | blk |
				blk := entryCompletion chooseBlock.
				entryCompletion
					chooseBlock: [ :v | 
						(blk value: v) = true
							ifTrue: [ 
								self setText: v.
								self acceptTextInModel ] ] ] ]
]
