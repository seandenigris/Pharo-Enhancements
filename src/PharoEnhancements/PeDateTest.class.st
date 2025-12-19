Class {
	#name : 'PeDateTest',
	#superclass : 'TestCase',
	#category : 'PharoEnhancements-Specification',
	#package : 'PharoEnhancements',
	#tag : 'Specification'
}

{ #category : 'tests' }
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

{ #category : 'tests' }
PeDateTest >> testIsAnniversaryReachedBy [

	| start end cases expected |
	cases := { 
		"Leap year to non leap year"
		{ '2/28/1980'. '2/27/1985'. false }.
		{ '2/28/1980'. '2/28/1985'. true }.
		{ '2/29/1980'. '2/28/1985'. false }.
		{ '2/29/1980'. '3/1/1985'. true }.
		{ '3/1/1980'. '2/28/1985'. false }.
		{ '3/1/1980'. '3/1/1985'. true }.
		
		"Leap year to leap year"
		{ '2/28/1980'. '2/27/1984'. false }.
		{ '2/28/1980'. '2/28/1984'. true }.
		{ '2/29/1980'. '2/28/1984'. false. }.
		{ '2/29/1980'. '2/29/1984'. true. }.
		{ '2/29/1980'. '3/1/1984'. true. }.
		{ '3/1/1980'. '2/29/1984'. false }.
		{ '3/1/1980'. '3/1/1984'. true }.
		
		"Non leap year to leap year"
		{ '2/28/1981'. '2/27/1988'. false }.
		{ '2/28/1981'. '2/28/1988'. true }.
		{ '3/1/1981'. '2/29/1988'. false }.
		{ '3/1/1981'. '3/1/1988'. true }.
		
		"Non leap year to non leap year"
		{ '2/28/1981'. '2/27/1987'. false }.
		{ '2/28/1981'. '2/28/1987'. true }.
		{ '3/1/1981'. '2/28/1987'. false }.
		{ '3/1/1981'. '3/1/1987'. true }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		end := e second asDate.
		expected := e third.
		
		self assert: (start isAnniversaryReachedBy: end) equals: expected ]
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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
		{ '2/29/2016'. '2/28/2017'. 365 / 366 }.
		{ '2/29/2016'. '3/1/2017'. 1 }.
		{ '3/1/2016'. '2/28/2017'. 364 / 365 }.
		{ '3/1/2016'. '3/1/2017'. 1 }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		end := e second asDate.
		expected := e third.
		
		self assert: (end yearsSince: start) equals: expected ]
]
