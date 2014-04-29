module grammar::Lexical

layout Standard = WhitespaceOrComment* !>> [\ \t\n\f\r] !>> "//";
  
lexical Comment = @category="Comment" "//" ![\n\r]* $;

syntax WhitespaceOrComment 
  = whitespace: Whitespace
  | comment: Comment
  ;   

lexical Whitespace 
  = [\u0009-\u000D \u0020 \u0085 \u00A0 \u1680 \u180E \u2000-\u200A \u2028 \u2029 \u202F \u205F \u3000]
  ; 
  
lexical Month = "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec";
  
lexical Percentage = [0-9]+ "." [0-9] "%";
lexical Period = "Day" | "Month" | "Quarter" | "Year";
lexical Bool = "True" | "False";
lexical Int = [0-9]+;
lexical String = "\"" ![\"]*  "\"";


lexical FunctionName = Id;
lexical EventName = Id;
lexical Var = Id;
lexical Field = Id;

lexical Id = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords;
keyword Keywords = Month | "case" | "sum" | "Day" | "Month" | "Quarter" | "Year" | "True" | "False" | "old";
