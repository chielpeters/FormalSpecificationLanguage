module grammar::Lexical

lexical Month = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec";
lexical Frequency = "Daily" | "Monthly" | "Quarterly" | "Yearly";
lexical Period = "Day" | "Month" | "Quarter" | "Year";
lexical Bool = "True" | "False";
syntax Date = Int day Month month;
lexical Percentage = [0-9]+ "." [0-9] "%";
lexical Int = [0-9]+ | "Inf";
lexical String = "\"" ![\"]*  "\"";

lexical FunctionName = Id;
lexical SavingsAccountName = Id;
lexical EventName = Id;
lexical Var = Id;
lexical Field = Id;
lexical Id = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords;

keyword Keywords = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" | 
					"Daily" | "Monthly" | "Quarterly" | "Yearly" | "Day" | "Month" | "Quarter" | "Year" | "True" | "False" | 
					"old" | "sum" | "case" | "Inf" | "in";

layout Standard = WhitespaceOrComment* !>> [\ \t\n\f\r];
lexical Comment = @category="Comment" "#" ![\n]* $;
lexical WhitespaceOrComment 
  = whitespace: Whitespace
  | Comment
  ;   
lexical Whitespace 
  = [\ \t\n\f\r]
  ; 