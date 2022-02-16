"
Adapted from [the antlr4 grammar](https://raw.githubusercontent.com/antlr/grammars-v4/master/toml/toml.g4).
"
Class {
	#name : #PeTOMLParser,
	#superclass : #SmaCCGLRParser,
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #generated }
PeTOMLParser class >> ambiguousTransitions [
^#(
#[ 0 202 1 33] 
#[ 0 202 1 37] 
#[ 0 242 1 77] 
#[ 0 86 0 254] 
#[ 1 2 1 97]
	).
]

{ #category : #'generated-accessing' }
PeTOMLParser class >> cacheId [
	^'2022-02-16T12:48:56.1306-05:00'
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
/*grammar toml;*/

/*
 * Parser Rules
 */

document : expression (<NL> expression)*  ;

expression : key_value comment | table comment | comment ;

comment: <COMMENT>? ;

key_value : key ""="" value ;

key : simple_key | dotted_key ;

simple_key : quoted_key | unquoted_key ;

unquoted_key : <UNQUOTED_KEY> ;

quoted_key :  <BASIC_STRING> | <LITERAL_STRING> ;

dotted_key : simple_key (""."" simple_key)+ ;

value : string | integer | floating_point | bool_ | date_time | array_ | inline_table ;

string : <BASIC_STRING> | <ML_BASIC_STRING> | <LITERAL_STRING> | <ML_LITERAL_STRING> ;

integer : <DEC_INT> | <HEX_INT> | <OCT_INT> | <BIN_INT> ;

floating_point : <FLOAT> | <INF> | <NAN> ;

bool_ : <BOOLEAN> ;

date_time : <OFFSET_DATE_TIME> | <LOCAL_DATE_TIME> | <LOCAL_DATE> | <LOCAL_TIME> ;

array_ : ""["" array_values? comment_or_nl ""]"" ;

array_values : (comment_or_nl value nl_or_comment "","" array_values comment_or_nl) | comment_or_nl value nl_or_comment "",""? ;

comment_or_nl : (<COMMENT>? <NL>)* ;
nl_or_comment : (<NL> <COMMENT>?)* ;

table : standard_table | array_table ;

standard_table : ""["" key ""]"" ;

inline_table : ""{"" inline_table_keyvals ""}"" ;

inline_table_keyvals : inline_table_keyvals_non_empty? ;

inline_table_keyvals_non_empty : key ""="" value ("","" inline_table_keyvals_non_empty)? ;

array_table : ""["" ""["" key ""]"" ""]"" ;

/*
 * Lexer Rules
 */

<whitespace> : \s+ /* TODO: -> skip*/ ;
<NL> : (\r? \n)+ ;
<NLBETTER> : (\r | \n | \r\n)+ ;
<COMMENT> : \# ([^\r\n])* ;

<DIGIT> : [0-9] ;
<ALPHA> : [A-Za-z] ;

# booleans
<BOOLEAN> : true | false ;

# strings
<ESC> : \\ ([\""\\\/bfnrt] | <UNICODE> | <EX_UNICODE>) ;
<ML_ESC> : \\ \r? \n | <ESC> ;
<UNICODE> : u <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<EX_UNICODE> : U <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<BASIC_STRING> : \"" (<ESC> | [^\""\\\n])*/* TODO: ? */ \"" ;
<ML_BASIC_STRING> : \""\""\"" (<ML_ESC> | [^\""\\])*/* TODO: ? */ \""\""\"" ;
<LITERAL_STRING> : \' ([^\'\n])*/* TODO: ? */ \' ;
<ML_LITERAL_STRING> : \'\'\' (.)*/* TODO: ? */ \'\'\';
# floating point numbers
<EXP> : [eE] [\+\-]? <ZERO_PREFIXABLE_INT> ;
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
	#(33 0 #reduceFor: 951297 false) 
	#(33 1 #reduceFor: 951298 false) 
	#(38 1 #reduceFor: 1115137 false) 
	#(38 1 #reduceFor: 1115138 false) 
	#(37 1 #reduceFor: 1081345 false) 
	#(31 0 #reduceFor: 866305 false) 
	#(32 1 #reduceFor: 889859 false) 
	#(35 1 #reduceFor: 1004545 false) 
	#(36 1 #reduceFor: 1038338 false) 
	#(36 1 #reduceFor: 1038337 false) 
	#(35 1 #reduceFor: 1004546 false) 
	#(56 1 #reduceFor: 1862657 false) 
	#(56 1 #reduceFor: 1862658 false) 
	#(29 2 #reduceFor: 843777 false) 
	#(32 2 #reduceFor: 889857 false) 
	#(41 1 #reduceFor: 1191937 false) 
	#(39 2 #reduceFor: 1167361 false) 
	#(32 2 #reduceFor: 889858 false) 
	#(57 3 #reduceFor: 1903617 false) 
	#(31 2 #reduceFor: 866306 false) 
	#(52 0 #reduceFor: 1802241 false) 
	#(59 0 #reduceFor: 1984513 false) 
	#(46 1 #reduceFor: 1500161 false) 
	#(43 1 #reduceFor: 1304577 false) 
	#(43 1 #reduceFor: 1304578 false) 
	#(43 1 #reduceFor: 1304579 false) 
	#(43 1 #reduceFor: 1304580 false) 
	#(45 1 #reduceFor: 1455105 false) 
	#(45 1 #reduceFor: 1455106 false) 
	#(45 1 #reduceFor: 1455107 false) 
	#(44 1 #reduceFor: 1394689 false) 
	#(44 1 #reduceFor: 1394690 false) 
	#(44 1 #reduceFor: 1394691 false) 
	#(44 1 #reduceFor: 1394692 false) 
	#(47 1 #reduceFor: 1521665 false) 
	#(47 1 #reduceFor: 1521666 false) 
	#(47 1 #reduceFor: 1521667 false) 
	#(47 1 #reduceFor: 1521668 false) 
	#(34 3 #reduceFor: 974849 false) 
	#(42 1 #reduceFor: 1213441 false) 
	#(42 1 #reduceFor: 1213442 false) 
	#(42 1 #reduceFor: 1213443 false) 
	#(42 1 #reduceFor: 1213444 false) 
	#(42 1 #reduceFor: 1213445 false) 
	#(42 1 #reduceFor: 1213446 false) 
	#(42 1 #reduceFor: 1213447 false) 
	#(40 2 #reduceFor: 1191937 false) 
	#(41 2 #reduceFor: 1191938 false) 
	#(30 2 #reduceFor: 866305 false) 
	#(50 1 #reduceFor: 1785857 false) 
	#(59 1 #reduceFor: 1984514 false) 
	#(61 5 #reduceFor: 2134017 false) 
	#(48 3 #reduceFor: 1607681 false) 
	#(55 0 #reduceFor: 1840129 false) 
	#(51 1 #reduceFor: 1802241 false) 
	#(52 2 #reduceFor: 1802242 false) 
	#(58 3 #reduceFor: 1936385 false) 
	#(48 4 #reduceFor: 1607682 false) 
	#(49 3 #reduceFor: 1656834 false) 
	#(53 1 #reduceFor: 1823745 false) 
	#(51 2 #reduceFor: 1802242 false) 
	#(60 3 #reduceFor: 2043905 false) 
	#(49 4 #reduceFor: 1656835 false) 
	#(54 1 #reduceFor: 1840129 false) 
	#(55 2 #reduceFor: 1840130 false) 
	#(54 2 #reduceFor: 1840130 false) 
	#(60 5 #reduceFor: 2043906 false) 
	#(49 6 #reduceFor: 1656833 false)
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
	     '(<NL> expression)' '(<NL> expression)*' 'expression'
	     'comment' 'key_value' 'key' 'simple_key' 'unquoted_key'
	     'quoted_key' 'dotted_key' '("." simple_key)' '("." simple_key)+'
	     'value' 'string' 'integer' 'floating_point' 'bool_' 'date_time'
	     'array_' 'array_values' 'comment_or_nl' '(<COMMENT>? <NL>)'
	     '(<COMMENT>? <NL>)*' 'nl_or_comment' '(<NL> <COMMENT>?)'
	     '(<NL> <COMMENT>?)*' 'table' 'standard_table' 'inline_table'
	     'inline_table_keyvals' 'inline_table_keyvals_non_empty'
	     'array_table' 'E O F' 'error' )
]

{ #category : #generated }
PeTOMLParser class >> transitionTable [
^#(
#[1 0 9 0 4 0 6 0 9 0 13 0 10 0 17 0 12 0 21 0 14 0 25 0 27 0 29 0 29 0 33 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39 0 65 0 56 0 69 0 57 0 73 0 61 0 6 0 62] 
#[1 0 77 0 4 0 17 0 12 0 21 0 14 0 25 0 27 0 81 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39] 
#[0 0 10 0 9 0 62] 
#[0 0 14 0 2 0 3 0 5] 
#[0 0 18 0 2 0 3 0 5] 
#[0 0 22 0 2 0 3 0 5] 
#[0 0 0 0 62] 
#[1 0 26 0 9 0 85 0 31 0 26 0 62] 
#[0 0 30 0 9 0 62] 
#[1 0 6 0 9 0 13 0 10 0 89 0 33 0 6 0 62] 
#[0 0 93 0 3] 
#[1 0 97 0 2 0 34 0 3 0 34 0 5 0 101 0 40 0 105 0 41] 
#[0 0 38 0 2 0 3 0 5] 
#[0 0 42 0 2 0 3 0 5] 
#[0 0 46 0 3 0 5] 
#[1 0 6 0 9 0 13 0 10 0 109 0 33 0 6 0 62] 
#[0 0 50 0 9 0 10 0 62] 
#[0 0 54 0 9 0 10 0 62] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 0 113 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39] 
#[0 0 117 0 5] 
#[1 0 121 0 9 0 125 0 30 0 58 0 62] 
#[0 0 62 0 9 0 62] 
#[1 0 129 0 4 0 133 0 6 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 0 201 0 42 0 205 0 43 0 209 0 44 0 213 0 45 0 217 0 46 0 221 0 47 0 225 0 48 0 229 0 58] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 0 233 0 36 0 53 0 37 0 57 0 38] 
#[0 0 66 0 2 0 3 0 5] 
#[1 0 97 0 2 0 70 0 3 0 70 0 5 0 237 0 40] 
#[0 0 74 0 9 0 62] 
#[0 0 241 0 5] 
#[0 0 78 0 9 0 10 0 62] 
#[1 0 9 0 4 0 6 0 9 0 13 0 10 0 17 0 12 0 21 0 14 0 25 0 27 0 245 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39 0 65 0 56 0 69 0 57 0 73 0 61 0 6 0 62] 
#[0 0 82 0 9 0 62] 
#[1 0 86 0 4 0 86 0 5 0 86 0 6 0 86 0 9 0 86 0 10 0 86 0 11 0 86 0 12 0 86 0 13 0 86 0 14 0 86 0 15 0 86 0 16 0 86 0 17 0 86 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 22 0 86 0 23 0 86 0 24 0 86 0 25 0 86 0 26 0 249 0 49 0 253 0 50 1 1 0 52] 
#[1 0 90 0 7 0 17 0 12 0 21 0 14 0 25 0 27 1 5 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39 1 9 0 59 1 13 0 60] 
#[0 0 94 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 98 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 102 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 106 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 110 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 114 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 118 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 122 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 126 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 130 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 134 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 138 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 142 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 146 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 150 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 154 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 158 0 9 0 10 0 62] 
#[0 0 162 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 166 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 170 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 174 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 178 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 182 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 186 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 190 0 2 0 3 0 5] 
#[0 0 194 0 2 0 3 0 5] 
#[0 1 17 0 5] 
#[0 0 198 0 9 0 62] 
#[1 0 86 0 5 0 86 0 9 0 86 0 10 1 21 0 50 1 1 0 52] 
#[1 0 129 0 4 1 25 0 5 0 133 0 6 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 29 0 42 0 205 0 43 0 209 0 44 0 213 0 45 0 217 0 46 0 221 0 47 0 225 0 48 0 229 0 58] 
#[1 0 202 0 4 0 202 0 5 0 202 0 6 0 7 0 9 0 11 0 10 0 202 0 11 0 202 0 12 0 202 0 13 0 202 0 14 0 202 0 15 0 202 0 16 0 202 0 17 0 202 0 18 0 202 0 19 0 202 0 20 0 202 0 21 0 202 0 22 0 202 0 23 0 202 0 24 0 202 0 25 0 202 0 26 1 41 0 51] 
#[0 1 45 0 3] 
#[0 1 49 0 7] 
#[0 0 206 0 7] 
#[0 0 210 0 9 0 10 0 62] 
#[0 1 53 0 5] 
#[0 0 214 0 1 0 5 0 7 0 9 0 10 0 62] 
#[1 0 218 0 1 0 218 0 5 0 218 0 9 0 218 0 10 1 57 0 53 1 61 0 55] 
#[0 0 222 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[0 1 65 0 9] 
#[0 0 226 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 0 129 0 4 0 133 0 6 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 69 0 42 0 205 0 43 0 209 0 44 0 213 0 45 0 217 0 46 0 221 0 47 0 225 0 48 0 229 0 58] 
#[0 0 230 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 234 0 1 0 5 0 7 0 9 0 10 0 62] 
#[1 1 73 0 1 0 238 0 5 0 238 0 9 0 238 0 10] 
#[1 0 242 0 1 0 242 0 5 0 15 0 9 0 242 0 10 1 81 0 54] 
#[0 0 246 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 1 85 0 1 0 250 0 7] 
#[1 0 86 0 4 0 254 0 5 0 86 0 6 0 19 0 9 0 19 0 10 0 86 0 11 0 86 0 12 0 86 0 13 0 86 0 14 0 86 0 15 0 86 0 16 0 86 0 17 0 86 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 22 0 86 0 23 0 86 0 24 0 86 0 25 0 86 0 26 1 89 0 49 1 93 0 50 1 1 0 52] 
#[1 1 2 0 1 1 2 0 5 1 2 0 9 0 23 0 10] 
#[0 1 6 0 1 0 5 0 9 0 10] 
#[1 0 17 0 12 0 21 0 14 0 25 0 27 1 5 0 35 0 49 0 36 0 53 0 37 0 57 0 38 0 61 0 39 1 101 0 60] 
#[1 0 86 0 5 0 86 0 9 0 86 0 10 1 105 0 50 1 1 0 52] 
#[1 0 129 0 4 0 133 0 6 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 29 0 42 0 205 0 43 0 209 0 44 0 213 0 45 0 217 0 46 0 221 0 47 0 225 0 48 0 229 0 58] 
#[0 1 10 0 1 0 5 0 9 0 10] 
#[0 1 14 0 7] 
#[0 1 18 0 5 0 9 0 10]
	).
]
