Extension { #name : 'LeMethodNameArgumentNode' }

{ #category : '*PharoEnhancements-GToolkit' }
LeMethodNameArgumentNode >> peImageObject [
	| cls |
	cls := super imageObject.
	^ (cls isNil or: [ cls isBehavior not ])
		ifFalse: [ 
			cls 
				compiledMethodAt: self methodName 
				ifAbsent: [ RGMethodDefinition realClass: cls selector: self methodName ] ]
		ifTrue: [ 
			RGMethodDefinition 
				className: self className 
				selector: self methodName 
				isMetaSide: self isMetaSide ]
]
