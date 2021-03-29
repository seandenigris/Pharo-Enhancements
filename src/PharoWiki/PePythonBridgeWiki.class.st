"
!Failure to install if paths have spaces
Until the PR is merged, you can get the fix by locking the repo prior to loading PythonBridge
[[[
Metacello new
	repository: 'github://seandenigris/PythonBridge:bug_install-filename-spaces';
	lock.
]]]
!P3Generator
This seems to be the primary way to use the bridge. It provides interesting features like the ability to modify the Python AST. Unfortunately, if you don't need that sort of thing, P3G brings a performance penalty that can overwhelm small scripts, extending operations that would usually be instantaneous to possibly 1/2 a second.
!!Missing ==from package import names==
Until the PR is merged, you can get by locking the repo prior to loading P3G
[[[
Metacello new
	repository: 'github://seandenigris/Python3Generator:enh_import-from';
	lock.
]]]

"
Class {
	#name : #PePythonBridgeWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}
