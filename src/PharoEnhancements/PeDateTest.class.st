Class {
	#name : #PeDateTest,
	#superclass : #TestCase,
	#category : #'PharoEnhancements-Specification'
}

{ #category : #tests }
PeDateTest >> testAddYears [

	| start increment cases expected |
	cases := { 
		{ '3/1/2016'. 1. '3/1/2017' }.
		
		"Leap year"
		{ '2/29/2016'. 4. '2/29/2020' }.
		{ '2/29/2016'. 1. '3/1/2017' }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		increment := e second.
		expected := e third asDate.
		
		self assert: (start addYears: increment) equals: expected ]
]

{ #category : #tests }
PeDateTest >> testSubtractYears [

	| start increment cases expected |
	cases := { 
		{ '3/1/2016'. 1. '3/1/2015' }.
		
		"Leap year"
		{ '2/29/2016'. 4. '2/29/2012' }.
		{ '2/29/2016'. 1. '3/1/2015' }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		increment := e second.
		expected := e third asDate.
		
		self assert: (start subtractYears: increment) equals: expected ]
]

{ #category : #tests }
PeDateTest >> testYearsSince [

	| start end cases expected |
	"See #yearsSince: method comment for explanation of return value"
	cases := { 
		{ '1/1/2018'. '1/2/2018'. 1 / 365 }.
		{ '1/1/2018'. '1/1/2019'. 1 }.
		{ '1/1/2018'. '1/2/2019'. 1 + (1 / 365) }.
		
		"Leap year"
		{ '1/1/2016'. '1/1/2017'. 1 }.
		{ '2/28/2016'. '3/1/2016'. 2 / 366 }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		end := e second asDate.
		expected := e third.
		
		self assert: (end yearsSince: start) equals: expected ]
]
