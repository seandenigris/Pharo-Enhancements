Extension { #name : #GTPlayBook }

{ #category : #'*PharoEnhancements' }
GTPlayBook class >> browseAll [
	<script>
	GTPlayBook instance allFiles inspect
]

{ #category : #'*PharoEnhancements' }
GTPlayBook class >> browseNamed [
	<script>
	(GTPlayBook instance allFiles reject: [ :e | e basename prefixMatchesRegex: '\d\d\d\d-' ]) inspect
]

{ #category : #'*PharoEnhancements' }
GTPlayBook class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Play Pages')
		parent: 'Tools';
		with: [
			(aBuilder item: #'Browse All')
				action: [ self browseAll ]; 
				icon: Smalltalk tools workspace taskbarIcon.
			(aBuilder item: #'Browse Named')
				action: [ self browseNamed ]; 
				icon: Smalltalk tools workspace taskbarIcon. ]
]
