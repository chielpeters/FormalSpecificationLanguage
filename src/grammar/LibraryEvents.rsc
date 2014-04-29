module grammar::LibraryEvents

extend grammar::Expressions;
extend grammar::Lexical;

start syntax Events = events: Event+ events;

syntax Event = event: Signature sig Parameters? Pre? Post?;

syntax Signature = eventsignature: EventName name "(" {Argument ","}* ")";
syntax Argument = argument: Type Id ("=" Expr)?;

syntax Parameters = "parameters" ":" {(Type Id) ","}*;
syntax Pre = "preconditions" ":" {Expr ","}*;
syntax Post = "postconditions" ":" {ExpressionsOrEventCall ","}*;


syntax ExpressionsOrEventCall =
	| expressions: Expr
	| multipleEventCalls: "(" ExpressionsOrEventCall "|" Var "\<-" Expr ")"
	| eventcall: EventName "(" {Expr ","}* ")" "[" {Expr ","}* "]"
	;