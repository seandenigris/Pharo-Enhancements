Extension { #name : 'LeDatabasesRegistry' }

{ #category : '*PharoEnhancements-GToolkit' }
LeDatabasesRegistry >> handleClassRenameFrom: oldClassName to: newClassName [
	| page pageRenamer typeMap |

	typeMap := (self defaultPlaygroundDatabase instVarNamed: #pagesByType) at: LePharoClassPageType.
	
	pageRenamer := [ :oldName :newName |
		typeMap 
			at: oldName asString
			ifPresent: [ 
				page := typeMap at: oldName.
				page type pageClassName: newName.
				typeMap at: newName put: page.
				typeMap removeKey: oldName ] ].
	
	pageRenamer value: oldClassName asString value: newClassName asString.
	pageRenamer value: oldClassName, ' class' value: newClassName, ' class'.
]
