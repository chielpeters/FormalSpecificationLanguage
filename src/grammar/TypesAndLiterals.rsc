module grammar::TypesAndLiterals

extend grammar::Lexical;

syntax Literal
  = integer: Int
  | boolean: Bool
  | period: Period
  | freq : Frequency
  | date: Date
  | percentage: Percentage
;

syntax Type
  = booleantype:  "Boolean"
  | period: "Period"
  | integer: "Integer"
  | date: "Date"
  | feq : "Freq"
  | percentage: "Percentage"
  | maptype: "map" "[" Type ":" Type "]"
  | listtype: "list" "[" Type "]"
  | settype: "set" "[" Type "]"
  | functiontype: Type "-\>" Type
  ;