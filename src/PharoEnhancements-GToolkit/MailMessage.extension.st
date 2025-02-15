Extension { #name : #MailMessage }

{ #category : #'*PharoEnhancements-GToolkit' }
MailMessage >> fieldsGtViewFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Fields';
		priority: 30;
		object: [ self fields ];
		view: #gtItemsFor:;
		yourself
]

{ #category : #'*PharoEnhancements-GToolkit' }
MailMessage >> sourceGtViewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Source' translated;
		priority: 40;
		text: [ self text ]
]
