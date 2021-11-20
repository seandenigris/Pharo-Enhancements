"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoEnhancements,
	#superclass : #PackageManifest,
	#category : 'PharoEnhancements-Core'
}

{ #category : #'code-critics' }
ManifestPharoEnhancements class >> ruleGRUsesCurlyBraceArraysRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#PharoEnhancements)) #'2018-08-26T16:20:35.927752+00:00') )
]
