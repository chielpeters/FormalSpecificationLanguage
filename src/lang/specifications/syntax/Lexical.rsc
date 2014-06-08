module lang::specifications::\syntax::Lexical

lexical FunctionName = @category="Identifier" Id;
lexical SpecificationName = @category="Identifier" Id;
lexical EventName = @category="Identifier" Id;
lexical Var = @category="Normal" Id | "Date" | "Integer" | "Period" | "Freq" | "Percentage"| "Boolean";
lexical InvariantName = @category="Identifier" Id;
lexical Field = @category="Variable" Id;
lexical CustomType = @category="Type" Id;
lexical FileName = Id;
lexical Id = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords;

keyword Keywords = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" | 
					"Daily" | "Monthly" | "Quarterly" | "Yearly" | "Day" | "Month" | "Quarter" | "Year" | "True" | "False" | 
					 "sum" | "case" | "Inf" | "in" | "parameters" | "preconditions" | "postconditions" | 
					"all" | "no" | "some" | "lone" | "one" | "inital" | "final" | "Date" | "Integer" | "Period" | "Freq" | "Percentage" | "Boolean";

layout Standard = WhitespaceOrComment* !>> [#\t-\n\r\ ];
lexical Comment = @category="Comment" "#" ![\n]* $;

lexical WhitespaceOrComment 
  = whitespace: Whitespace
  | Comment
  ;   
lexical Whitespace
  = [\t-\n\r\ ]
  ; 
  