Extension { #name : #MAToManyRelationDescription }

{ #category : #'*PharoEnhancements-Magritte' }
MAToManyRelationDescription >> referenceDisplay: aSymbol [

	| stringDesc container |
	stringDesc := MAStringDescription new   
		selectorAccessor: aSymbol; 
		yourself.
	container := MAContainer with: stringDesc.
	self reference: container.
	
	"Implementation note: This seemingly hacky solution relies on the fact that a container writes itself as a string by writing each child description as a string. So by creating a container with only one string description, that becomes the string result. Guessing that this is to avoid subclassing the string writer, but it seems one could come up with something pluggable and explicitly setting the string writer seems more intention revealing.
	
	The current solution comes from these sources:
		- The comment of ${method:MARelationDescription>>#reference}$ has this tantalizing hint: ==By setting the reference to a MAContainer instance it is possible to customize the reference description==. 
		- Magritte does not seem to offer any examples of how that would actually work, but luckily Lukas provided one [1]:
> you want a different string to be displayed? If so, try this 
==
	reference: (MAContainer with: (MAStringDescription new   
		selectorAccessor: #printString; yourself)) 
==
>and implement your own printOn: method in your referenced object as   
you wish. 
	
	1. [Lukas on customizing references via the Magritte ML](http://forum.world.st/MAToOneRelationDescription-dispaly-data-tp117214p117218.html)"
]
