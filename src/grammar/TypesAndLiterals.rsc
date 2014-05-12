module grammar::TypesAndLiterals

extend grammar::Lexical;

syntax Literal
  = integer: Int
  | boolean: Bool
  | period: Period
  | var : Var
  | freq : Frequency
  | date: Date
  | percentage: Percentage
  | mapLit: "("  MapElements ")"
  | listLit: "[" LiteralList  "]"
  | setLit: "{" LiteralList "}"
  ;

syntax MapElements = {MapElement ","}* elems;
syntax MapElement = Literal key ":" Literal val;
syntax LiteralList = {Literal ","}* lits;

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