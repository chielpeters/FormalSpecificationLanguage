module lang::savingsaccounts::\syntax::TypesAndLiterals

extend lang::savingsaccounts::\syntax::Lexical;

syntax Literal
  = @category="Constant" integer: Int
  | @category="Constant" boolean: Bool
  | @category="Constant" period: Period
  | @category="Constant" freq : Frequency
  | @category="Constant" date: Date
  | @category="Constant" percentage: Percentage
;

syntax Type
  = @category="Type" booleantype:  "Boolean"
  | @category="Type" period: "Period"
  | @category="Type" integer: "Integer"
  | @category="Type" date: "Date"
  | @category="Type" feq : "Freq"
  | @category="Type" percentage: "Percentage"
  | @category="Type" maptype: "map" "[" Type ":" Type "]"
  | @category="Type" listtype: "list" "[" Type "]"
  | @category="Type" settype: "set" "[" Type "]"
  | @category="Type" functiontype: Type "-\>" Type
  ;

/*********************************************
* Literals
*********************************************/

lexical Month = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec";
lexical Frequency =  "Daily" | "Monthly" | "Quarterly" | "Yearly";
lexical Period =  "Day" | "Month" | "Quarter" | "Year";
lexical Bool =  "True" | "False";
syntax Date = Int day Month month;
lexical Percentage = [0-9]+ "%";
lexical Int = [0-9]+ |  "Inf";
lexical String = "\"" ![\"]*  "\"";