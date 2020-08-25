"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoEnhancementsPetitParser,
	#superclass : #PackageManifest,
	#category : #'PharoEnhancements-PetitParser2-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoEnhancementsPetitParser class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PP2DateParserTest #failParse:rule: #false)) #'2019-12-04T20:50:13.042864-05:00') )
]
