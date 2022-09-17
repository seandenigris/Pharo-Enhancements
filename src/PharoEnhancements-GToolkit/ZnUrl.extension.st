Extension { #name : #ZnUrl }

{ #category : #'*PharoEnhancements-GToolkit' }
ZnUrl >> peLepiterClippedString [
	"Parens and brackets are allowed in <> markup, but not [](). See issue here: https://github.com/feenkcom/gtoolkit/issues/2749"

	| safeSet safeString |
	safeSet := self asString copyWithoutAll: '()[]'.
	safeString := ZnPercentEncoder new
		characterEncoder: ZnDefaultCharacterEncoder value;
		safeSet: safeSet;
		encode: self asString.
	Clipboard clipboardText: safeString.
	^ safeString
]
