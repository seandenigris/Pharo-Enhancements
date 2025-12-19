Extension { #name : 'MAElementDescription' }

{ #category : '*PharoEnhancements-GToolkit' }
MAElementDescription >> blocStencil [

	^ self propertyAt: #blocStencil ifAbsent: [ nil ]
]

{ #category : '*PharoEnhancements-GToolkit' }
MAElementDescription >> blocStencil: aBlock [
	self propertyAt: #blocStencil put: aBlock
]
