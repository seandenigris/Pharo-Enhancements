Extension { #name : 'PBExecutionHandler' }

{ #category : '*PharoEnhancements-GToolkit' }
PBExecutionHandler >> newCommandSourceFactory [
	^ PBCommandSourceFactory new
		application: self application;
		yourself
]
