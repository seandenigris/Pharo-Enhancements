Extension { #name : #LePage }

{ #category : #'*PharoEnhancements-GToolkit' }
LePage >> asContentUIModel [
	<return: #LeContentViewModel>
	^ self type asContentUIModel
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePage class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		addFirst: (#type -> #pageType);
		addFirst: (#basicUid -> #uid);
		yourself
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePage >> snippetBuilder [
	^ self type snippetBuilder
]
