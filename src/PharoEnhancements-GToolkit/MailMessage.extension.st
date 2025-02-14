Extension { #name : #MailMessage }

{ #category : #'*PharoEnhancements-GToolkit' }
MailMessage >> bodyTextGtViewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Body' translated;
		priority: 20;
		text: [ self bodyText ]
]

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
