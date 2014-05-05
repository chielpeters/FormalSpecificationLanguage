module grammar::Events

extend grammar::Functions;
extend grammar::Expressions;
extend grammar::Lexical;

start syntax Events = events: Event+ events;

syntax Event = event: Signature sig Parameters? param Pre? pre  Post? post;

syntax Signature = eventsignature: EventName name "(" {EventArgument ","}* args")";
syntax EventArgument = eventargument: Type t Var var ("=" Expr exp)?;

syntax Parameters = "parameters" ":" Arguments args;
syntax Pre = "preconditions" ":" {Condition ","}* preconditions;
syntax Post = "postconditions" ":" {Condition ","}* postconditions;


syntax Condition =
	expression: Expr
	| multipleEventCalls: "(" Condition "|" Var "\<-" Expr ")"
	| eventcall: EventName "(" {Expr ","}* ")" "[" {Expr ","}* "]"
	;