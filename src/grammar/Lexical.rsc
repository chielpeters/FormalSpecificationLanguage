module grammar::Lexical

lexical Month = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec";
lexical Frequency =  "Daily" | "Monthly" | "Quarterly" | "Yearly";
lexical Period =  "Day" | "Month" | "Quarter" | "Year";
lexical Bool =  "True" | "False";
syntax Date = Int day Month month;
lexical Percentage = [0-9]+ "%";
lexical Int = [0-9]+ |  "Inf";
lexical String = "\"" ![\"]*  "\"";

lexical FunctionName = @category="Identifier" Id;
lexical SavingsAccountName = @category="Identifier" Id;
lexical EventName = @category="Identifier" Id;
lexical Var = @category="Normal" Id;
lexical InvariantName = @category="Identifier" Id;
lexical Field = @category="Variable" Id;
lexical Id = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords;

keyword Keywords = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" | 
					"Daily" | "Monthly" | "Quarterly" | "Yearly" | "Day" | "Month" | "Quarter" | "Year" | "True" | "False" | 
					"old" | "sum" | "case" | "Inf" | "in" | "parameters" | "preconditions" | "postconditions" | 
					"all" | "no" | "some" | "lone" | "one" |;

layout Standard = WhitespaceOrComment* !>> [\t-\n\r\ ];
lexical Comment = @category="Comment" "#" ![\n]* $;
lexical WhitespaceOrComment 
  = whitespace: Whitespace
  | Comment
  ;   
lexical Whitespace
  = [\t-\n\r\ ]
  ; 