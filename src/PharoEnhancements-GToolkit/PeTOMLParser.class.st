Class {
	#name : #PeTOMLParser,
	#superclass : #SmaCCGLRParser,
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTOMLParser class >> ambiguousTransitions [
^#(
#[ 0 218 1 49] 
#[ 0 218 1 53] 
#[ 1 2 1 93] 
#[ 0 94 1 14] 
#[ 1 18 1 113]
	).
]

{ #category : #'generated-accessing' }
PeTOMLParser class >> cacheId [
	^'2022-03-21T14:10:09.099867-04:00'
]

{ #category : #generated }
PeTOMLParser class >> definitionComment [
"/*
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
""License""); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  ""AS IS"" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
*/

%glr;
%annotate_tokens;
%root Parse;
%prefix PeToml;
%suffix Node;
/*grammar toml;*/

/*
 * Parser Rules
 */

document : expression 'expression' (<NL> expression 'expression')* {{}};

expression : key_value 'keyValue' comment 'comment' | table comment 'comment' | comment 'comment' {{}};

comment: <COMMENT>? ;

key_value : key 'key' ""="" value 'value' { key -> value };

key : simple_key | dotted_key;

simple_key : quoted_key | unquoted_key ;

unquoted_key : <UNQUOTED_KEY> 'string' { string value };

quoted_key 
	:  basicString
	| literalString;
literalString
	: <LITERAL_STRING> 'string' { string value copyFrom: 2 to: string value size - 1 }
	;
basicString
	: <BASIC_STRING> 'string' { string value copyFrom: 2 to: string value size - 1 }
	;

dotted_key : simple_key (""."" simple_key)+;

value 
	: string
	| integer 
	| floating_point 
	| bool_ 
	| date_time 
	| array_ 
	| inline_table;

string : basicString | mlBasicString | literalString | mlLiteralString ;
mlLiteralString
	: <ML_LITERAL_STRING> 'string' { string value copyFrom: 4 to: string value size -3 }
	;
mlBasicString
	: <ML_BASIC_STRING> 'string' { string value copyFrom: 4 to: string value size -3 }
	;

integer 
	: <DEC_INT> 'int' { (int value copyWithoutAll: '_') asNumber } 
	| <HEX_INT> 
	| <OCT_INT> 
	| <BIN_INT> ;

floating_point : <FLOAT> | <INF> | <NAN> ;

bool_ : <BOOLEAN> 'bool' { bool value = 'true' };

date_time 
	: <OFFSET_DATE_TIME> 'dt' { dt value asDateAndTime } 
	| <LOCAL_DATE_TIME>'dt' { dt value asDateAndTime } 
	| <LOCAL_DATE> 'date' { date value asDate } 
	| <LOCAL_TIME> 'time' { time value asTime } ;
array_ : ""["" array_values? comment_or_nl ""]"" ;

array_values : (comment_or_nl value 'value' nl_or_comment "","" array_values comment_or_nl) | comment_or_nl value 'value' nl_or_comment "",""? ;

comment_or_nl : (<COMMENT>? <NL>)* ;
nl_or_comment : (<NL> <COMMENT>?)* ;

table : standard_table | array_table ;

standard_table : ""["" key 'key' ""]"" {{}};

inline_table : ""{"" inline_table_keyvals ""}"" ;

inline_table_keyvals : inline_table_keyvals_non_empty? ;

inline_table_keyvals_non_empty : key 'key' ""="" value 'value' ("","" inline_table_keyvals_non_empty)? ;

array_table : ""["" ""["" key 'key' ""]"" ""]"" {{}};

/*
 * Lexer Rules
 */

<whitespace> : [\ \t]+ ;
<NL> : (\r? \n)+ ;
<COMMENT> : \# ([^\n])* ;

<DIGIT> : [0-9] ;
<ALPHA> : [A-Za-z] ;

# booleans
<BOOLEAN> : true | false ;

# strings
<ESC> : \\ ([\""\\\/bfnrt] | <UNICODE> | <EX_UNICODE>) ;
<ML_ESC> : \\ \r? \n | <ESC> ;
<UNICODE> : u <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<EX_UNICODE> : U <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<BASIC_STRING> : \"" (<ESC> | [^\""\\\n])* \"" ;
<ML_BASIC_STRING> : \""\""\"" (<ML_ESC> | [^\""\\])* \""\""\"" ;
<LITERAL_STRING> : \' ([^\'\n])* \' ;
<ML_LITERAL_STRING> : \'\'\' ( [^\\\'] | \'[^\'] | \'\'[^\'] )* \'\'\';
# floating point numbers
<EXP> : (e | E) [\+\-]? <ZERO_PREFIXABLE_INT> ;
<ZERO_PREFIXABLE_INT> : <DIGIT> (<DIGIT> | _ <DIGIT>)* ;
<FRAC> : \. <ZERO_PREFIXABLE_INT> ;
<FLOAT> : <DEC_INT> ( <EXP> | <FRAC> <EXP>?) ;
<INF> : [\+\-]? inf ;
<NAN> : [\+\-]? nan ;
# integers
<HEX_DIGIT> : [A-Fa-f] | <DIGIT> ;
<DIGIT_1_9> : [1-9] ;
<DIGIT_0_7> : [0-7] ;
<DIGIT_0_1> : [0-1] ;
<DEC_INT> : [\+\-]? (<DIGIT> | (<DIGIT_1_9> (<DIGIT> | _ <DIGIT>)+)) ;
<HEX_INT> : 0x <HEX_DIGIT> (<HEX_DIGIT> | _ <HEX_DIGIT>)* ;
<OCT_INT> : 0o <DIGIT_0_7> (<DIGIT_0_7> | _ <DIGIT_0_7>)* ;
<BIN_INT> : 0b <DIGIT_0_1> (<DIGIT_0_1> | _ <DIGIT_0_1>)* ;
# dates
<YEAR> : <DIGIT> <DIGIT> <DIGIT> <DIGIT> ;
<MONTH> : <DIGIT> <DIGIT> ;
<DAY> : <DIGIT> <DIGIT> ;
<DELIM> : T | t | \  ;
<HOUR> : <DIGIT> <DIGIT> ;
<MINUTE> : <DIGIT> <DIGIT> ;
<SECOND> : <DIGIT> <DIGIT> ;
<SECFRAC> : \. <DIGIT>+ ;
<NUMOFFSET> : (\+ | \-) <HOUR> \: <MINUTE> ;
<OFFSET> : Z | <NUMOFFSET> ;
<PARTIAL_TIME> : <HOUR> \: <MINUTE> \: <SECOND> <SECFRAC>? ;
<FULL_DATE> : <YEAR> \- <MONTH> \- <DAY> ;
<FULL_TIME> : <PARTIAL_TIME> <OFFSET> ;
<OFFSET_DATE_TIME> : <FULL_DATE> <DELIM> <FULL_TIME> ;
<LOCAL_DATE_TIME> : <FULL_DATE> <DELIM> <PARTIAL_TIME> ;
<LOCAL_DATE> : <FULL_DATE> ;
<LOCAL_TIME> : <PARTIAL_TIME> ;
# keys
<UNQUOTED_KEY> : (<ALPHA> | <DIGIT> | \- | _)+ ;"
]

{ #category : #generated }
PeTOMLParser class >> reduceTable [
^#(
	#(33 0 #nil 1089537 false) 
	#(33 1 #liftFirstValue: 1089538 false) 
	#(40 1 #reduceActionForbasicString1: 1459201 false) 
	#(39 1 #reduceActionForbasicString1: 1355777 false) 
	#(37 1 #reduceActionForunquoted_key1: 1249281 false) 
	#(31 0 #reduceActionFor__NL__expression__expression___1: 942081 false) 
	#(32 1 #reduceActionForexpression3: 982019 false) 
	#(35 1 #liftFirstValue: 1173505 false) 
	#(36 1 #liftFirstValue: 1206274 false) 
	#(36 1 #liftFirstValue: 1206273 false) 
	#(38 1 #liftFirstValue: 1308674 false) 
	#(38 1 #liftFirstValue: 1308673 false) 
	#(35 1 #liftFirstValue: 1173506 false) 
	#(60 1 #liftFirstValue: 2701313 false) 
	#(60 1 #liftFirstValue: 2701314 false) 
	#(29 2 #reduceActionFordocument1: 906241 false) 
	#(32 2 #liftFirstValue: 982017 false) 
	#(43 1 #liftFirstValue: 1584129 false) 
	#(41 2 #liftFirstValue: 1559553 false) 
	#(32 2 #liftFirstValue: 982018 false) 
	#(61 3 #reduceActionForstandard_table1: 2742273 false) 
	#(31 2 #reduceActionFor__NL__expression__expression___2: 942082 false) 
	#(56 0 #nil 2640897 false) 
	#(63 0 #nil 2833409 false) 
	#(50 1 #reduceActionForbool_1: 2160641 false) 
	#(47 1 #reduceActionFormlBasicString1: 1890305 false) 
	#(46 1 #reduceActionFormlBasicString1: 1782785 false) 
	#(49 1 #liftFirstValue: 2115585 false) 
	#(49 1 #liftFirstValue: 2115586 false) 
	#(49 1 #liftFirstValue: 2115587 false) 
	#(48 1 #reduceActionForinteger1: 1994753 false) 
	#(48 1 #liftFirstValue: 1994754 false) 
	#(48 1 #liftFirstValue: 1994755 false) 
	#(48 1 #liftFirstValue: 1994756 false) 
	#(51 1 #reduceActionFordate_time1: 2212865 false) 
	#(51 1 #reduceActionFordate_time1: 2212866 false) 
	#(51 1 #reduceActionFordate_time3: 2212867 false) 
	#(51 1 #reduceActionFordate_time4: 2212868 false) 
	#(45 1 #liftFirstValue: 1708035 false) 
	#(45 1 #liftFirstValue: 1708033 false) 
	#(34 3 #reduceActionForkey_value1: 1113089 false) 
	#(44 1 #liftFirstValue: 1604609 false) 
	#(45 1 #liftFirstValue: 1708036 false) 
	#(45 1 #liftFirstValue: 1708034 false) 
	#(44 1 #liftFirstValue: 1604610 false) 
	#(44 1 #liftFirstValue: 1604611 false) 
	#(44 1 #liftFirstValue: 1604612 false) 
	#(44 1 #liftFirstValue: 1604613 false) 
	#(44 1 #liftFirstValue: 1604614 false) 
	#(44 1 #liftFirstValue: 1604615 false) 
	#(42 2 #liftSecondValue: 1584129 false) 
	#(43 2 #liftFirstValue: 1584130 false) 
	#(30 2 #reduceActionFor__NL__expression__expression__1: 942081 false) 
	#(54 1 #liftFirstValue: 2624513 false) 
	#(63 1 #liftFirstValue: 2833410 false) 
	#(65 5 #reduceActionForarray_table1: 2997249 false) 
	#(52 3 #liftSecondValue: 2429953 false) 
	#(59 0 #nil 2678785 false) 
	#(55 1 #liftFirstValue: 2640897 false) 
	#(56 2 #liftFirstValue: 2640898 false) 
	#(62 3 #liftSecondValue: 2785281 false) 
	#(52 4 #liftSecondValue: 2429954 false) 
	#(53 3 #liftFirstValue: 2479106 false) 
	#(57 1 #liftFirstValue: 2662401 false) 
	#(55 2 #liftFirstValue: 2640898 false) 
	#(64 3 #liftFirstValue: 2892801 false) 
	#(53 4 #liftFirstValue: 2479107 false) 
	#(58 1 #liftFirstValue: 2678785 false) 
	#(59 2 #liftFirstValue: 2678786 false) 
	#(58 2 #liftFirstValue: 2678786 false) 
	#(64 5 #liftFirstValue: 2892802 false) 
	#(53 6 #liftFirstValue: 2479105 false)
	).
]

{ #category : #generated }
PeTOMLParser class >> scannerClass [
	^PeTOMLScanner
]

{ #category : #generated }
PeTOMLParser class >> startingStateFordocument [

	^ 1
]

{ #category : #generated }
PeTOMLParser class >> symbolNames [

	^ #( '","' '"."' '"="' '"["' '"]"' '"{"' '"}"' '<whitespace>'
	     '<NL>' '<COMMENT>' '<BOOLEAN>' '<BASIC_STRING>' '<ML_BASIC_STRING>'
	     '<LITERAL_STRING>' '<ML_LITERAL_STRING>' '<FLOAT>' '<INF>'
	     '<NAN>' '<DEC_INT>' '<HEX_INT>' '<OCT_INT>' '<BIN_INT>'
	     '<OFFSET_DATE_TIME>' '<LOCAL_DATE_TIME>' '<LOCAL_DATE>'
	     '<LOCAL_TIME>' '<UNQUOTED_KEY>' 'B e g i n' 'document'
	     '(<NL> expression ''expression'')'
	     '(<NL> expression ''expression'')*'
	     'expression' 'comment' 'key_value' 'key' 'simple_key'
	     'unquoted_key' 'quoted_key' 'literalString' 'basicString'
	     'dotted_key' '("." simple_key)' '("." simple_key)+'
	     'value' 'string' 'mlLiteralString' 'mlBasicString'
	     'integer' 'floating_point' 'bool_' 'date_time' 'array_' 'array_values'
	     'comment_or_nl' '(<COMMENT>? <NL>)' '(<COMMENT>? <NL>)*'
	     'nl_or_comment' '(<NL> <COMMENT>?)' '(<NL> <COMMENT>?)*'
	     'table' 'standard_table' 'inline_table' 'inline_table_keyvals'
	     'inline_table_keyvals_non_empty'
	     'array_table' 'E O F' 'error' )
]

{ #category : #generated }
PeTOMLParser class >> symbolTypes [

	^ #( #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #PeTomlDocumentNode #PeTomlDocumentNode
	     #OrderedCollection #OrderedCollection #Object #SmaCCToken
	     #Object #Object #Object #Object #Object #Object #Object #Object
	     #Object #Object #Object #Object #Object #Object #Object #SmaCCToken
	     #Object #Object nil nil nil #SmaCCToken nil nil #SmaCCToken
	     nil #PeTomlParseNode #PeTomlStandardTableNode
	     #Object #Object #Object #PeTomlArrayTableNode
	     #SmaCCToken #SmaCCErrorNode )
]

{ #category : #generated }
PeTOMLParser class >> transitionTable [
^#(
#[1 0 9 0 4 0 6 0 9 0 37 0 10 0 17 0 12 0 21 0 14 0 25 0 27 0 29 0 29 0 33 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 0 45 0 41 0 73 0 60 0 73 0 61 0 73 0 65 0 6 0 66] 
#[1 0 85 0 4 0 17 0 12 0 21 0 14 0 25 0 27 0 89 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 0 89 0 41] 
#[0 0 10 0 9 0 66] 
#[0 0 14 0 1 0 2 0 3 0 5 0 7 0 9 0 10 0 66] 
#[0 0 18 0 1 0 2 0 3 0 5 0 7 0 9 0 10 0 66] 
#[0 0 22 0 2 0 3 0 5] 
#[0 0 0 0 66] 
#[1 0 26 0 9 0 93 0 31 0 26 0 66] 
#[0 0 30 0 9 0 66] 
#[1 0 6 0 9 0 97 0 10 0 97 0 33 0 6 0 66] 
#[0 0 101 0 3] 
#[1 0 105 0 2 0 34 0 3 0 34 0 5 0 113 0 42 0 113 0 43] 
#[0 0 38 0 2 0 3 0 5] 
#[0 0 42 0 2 0 3 0 5] 
#[0 0 46 0 2 0 3 0 5] 
#[0 0 50 0 2 0 3 0 5] 
#[0 0 54 0 3 0 5] 
#[1 0 6 0 9 0 117 0 10 0 117 0 33 0 6 0 66] 
#[0 0 58 0 9 0 10 0 66] 
#[0 0 62 0 9 0 10 0 66] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 0 121 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 0 121 0 41] 
#[0 0 125 0 5] 
#[1 0 129 0 9 0 133 0 30 0 66 0 66] 
#[0 0 70 0 9 0 66] 
#[1 0 137 0 4 0 141 0 6 0 145 0 11 0 17 0 12 0 149 0 13 0 21 0 14 0 153 0 15 0 209 0 16 0 209 0 17 0 209 0 18 0 169 0 19 0 209 0 20 0 209 0 21 0 209 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 0 209 0 39 0 209 0 40 0 209 0 44 0 209 0 45 0 209 0 46 0 209 0 47 0 209 0 48 0 209 0 49 0 209 0 50 0 209 0 51 0 209 0 52 0 209 0 62] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 0 249 0 36 0 249 0 37 0 249 0 38 0 249 0 39 0 249 0 40] 
#[0 0 74 0 2 0 3 0 5] 
#[1 0 105 0 2 0 78 0 3 0 78 0 5 0 253 0 42] 
#[0 0 82 0 9 0 66] 
#[0 1 1 0 5] 
#[0 0 86 0 9 0 10 0 66] 
#[1 0 9 0 4 0 6 0 9 0 37 0 10 0 17 0 12 0 21 0 14 0 25 0 27 1 5 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 0 45 0 41 0 73 0 60 0 73 0 61 0 73 0 65 0 6 0 66] 
#[0 0 90 0 9 0 66] 
#[1 0 94 0 4 0 94 0 5 0 94 0 6 0 94 0 9 0 94 0 10 0 94 0 11 0 94 0 12 0 94 0 13 0 94 0 14 0 94 0 15 0 94 0 16 0 94 0 17 0 94 0 18 0 94 0 19 0 94 0 20 0 94 0 21 0 94 0 22 0 94 0 23 0 94 0 24 0 94 0 25 0 94 0 26 1 9 0 53 1 13 0 54 1 17 0 56] 
#[1 0 98 0 7 0 17 0 12 0 21 0 14 0 25 0 27 1 21 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 1 21 0 41 1 25 0 63 1 25 0 64] 
#[0 0 102 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 106 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 110 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 114 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 118 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 122 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 126 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 130 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 134 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 138 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 142 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 146 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 150 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 154 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 158 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 162 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 166 0 9 0 10 0 66] 
#[0 0 170 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 174 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 178 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 182 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 186 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 190 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 194 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 198 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 202 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 206 0 2 0 3 0 5] 
#[0 0 210 0 2 0 3 0 5] 
#[0 1 33 0 5] 
#[0 0 214 0 9 0 66] 
#[1 0 94 0 5 0 94 0 9 0 94 0 10 1 37 0 54 1 17 0 56] 
#[1 0 137 0 4 1 41 0 5 0 141 0 6 0 145 0 11 0 17 0 12 0 149 0 13 0 21 0 14 0 153 0 15 1 45 0 16 1 45 0 17 1 45 0 18 0 169 0 19 1 45 0 20 1 45 0 21 1 45 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 45 0 39 1 45 0 40 1 45 0 44 1 45 0 45 1 45 0 46 1 45 0 47 1 45 0 48 1 45 0 49 1 45 0 50 1 45 0 51 1 45 0 52 1 45 0 62] 
#[1 0 218 0 4 0 218 0 5 0 218 0 6 0 7 0 9 0 11 0 10 0 218 0 11 0 218 0 12 0 218 0 13 0 218 0 14 0 218 0 15 0 218 0 16 0 218 0 17 0 218 0 18 0 218 0 19 0 218 0 20 0 218 0 21 0 218 0 22 0 218 0 23 0 218 0 24 0 218 0 25 0 218 0 26 1 57 0 55] 
#[0 1 61 0 3] 
#[0 1 65 0 7] 
#[0 0 222 0 7] 
#[0 0 226 0 9 0 10 0 66] 
#[0 1 69 0 5] 
#[0 0 230 0 1 0 5 0 7 0 9 0 10 0 66] 
#[1 0 234 0 1 0 234 0 5 0 234 0 9 0 234 0 10 1 73 0 57 1 77 0 59] 
#[0 0 238 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[0 1 81 0 9] 
#[0 0 242 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 0 137 0 4 0 141 0 6 0 145 0 11 0 17 0 12 0 149 0 13 0 21 0 14 0 153 0 15 1 85 0 16 1 85 0 17 1 85 0 18 0 169 0 19 1 85 0 20 1 85 0 21 1 85 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 85 0 39 1 85 0 40 1 85 0 44 1 85 0 45 1 85 0 46 1 85 0 47 1 85 0 48 1 85 0 49 1 85 0 50 1 85 0 51 1 85 0 52 1 85 0 62] 
#[0 0 246 0 1 0 5 0 7 0 9 0 10 0 66] 
#[0 0 250 0 1 0 5 0 7 0 9 0 10 0 66] 
#[1 1 89 0 1 0 254 0 5 0 254 0 9 0 254 0 10] 
#[1 1 2 0 1 1 2 0 5 0 15 0 9 1 2 0 10 1 97 0 58] 
#[0 1 6 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 1 101 0 1 1 10 0 7] 
#[1 0 94 0 4 1 14 0 5 0 94 0 6 0 19 0 9 0 19 0 10 0 94 0 11 0 94 0 12 0 94 0 13 0 94 0 14 0 94 0 15 0 94 0 16 0 94 0 17 0 94 0 18 0 94 0 19 0 94 0 20 0 94 0 21 0 94 0 22 0 94 0 23 0 94 0 24 0 94 0 25 0 94 0 26 1 105 0 53 1 109 0 54 1 17 0 56] 
#[1 1 18 0 1 1 18 0 5 1 18 0 9 0 23 0 10] 
#[0 1 22 0 1 0 5 0 9 0 10] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 1 21 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 49 0 39 0 49 0 40 1 21 0 41 1 117 0 64] 
#[1 0 94 0 5 0 94 0 9 0 94 0 10 1 121 0 54 1 17 0 56] 
#[1 0 137 0 4 0 141 0 6 0 145 0 11 0 17 0 12 0 149 0 13 0 21 0 14 0 153 0 15 1 45 0 16 1 45 0 17 1 45 0 18 0 169 0 19 1 45 0 20 1 45 0 21 1 45 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 45 0 39 1 45 0 40 1 45 0 44 1 45 0 45 1 45 0 46 1 45 0 47 1 45 0 48 1 45 0 49 1 45 0 50 1 45 0 51 1 45 0 52 1 45 0 62] 
#[0 1 26 0 1 0 5 0 9 0 10] 
#[0 1 30 0 7] 
#[0 1 34 0 5 0 9 0 10]
	).
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression__1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression___1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression___2: nodes [

	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_table1: nodes [

	| result |
	result := PeTomlArrayTableNode new.
	result addToken: (nodes at: 1) to: result leftBracketTokens.
	result addToken: (nodes at: 2) to: result leftBracketTokens.
	result key: (nodes at: 3).
	result addToken: (nodes at: 4) to: result rightBracketTokens.
	result addToken: (nodes at: 5) to: result rightBracketTokens.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForbasicString1: nodes [

	^ (nodes at: 1) value copyFrom: 2 to: (nodes at: 1) value size - 1
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForbool_1: nodes [

	^ (nodes at: 1) value = 'true'
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordate_time1: nodes [

	^ (nodes at: 1) value asDateAndTime
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordate_time3: nodes [

	^ (nodes at: 1) value asDate
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordate_time4: nodes [

	^ (nodes at: 1) value asTime
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordocument1: nodes [

	| result |
	result := PeTomlDocumentNode new.
	result addObject: (nodes at: 1) to: result expressions.
	result addTokens: ((nodes at: 2) at: 1) to: result nLTokens.
	result addObjects: ((nodes at: 2) at: 2) to: result expressions.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForexpression3: nodes [

	| result |
	result := PeTomlExpressionNode new.
	result comment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinteger1: nodes [

	^ ((nodes at: 1) value copyWithoutAll: '_') asNumber
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForkey_value1: nodes [

	^ (nodes at: 1) -> (nodes at: 3)
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFormlBasicString1: nodes [

	^ (nodes at: 1) value copyFrom: 4 to: (nodes at: 1) value size - 3
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForstandard_table1: nodes [

	| result |
	result := PeTomlStandardTableNode new.
	result leftBracketToken: (nodes at: 1).
	result key: (nodes at: 2).
	result rightBracketToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForunquoted_key1: nodes [

	^ (nodes at: 1) value
]
