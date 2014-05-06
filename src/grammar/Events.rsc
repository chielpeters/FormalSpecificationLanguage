module grammar::Events

extend grammar::Functions;
extend grammar::Expressions;
extend grammar::Lexical;

start syntax Events = events: Event+ events;

syntax Event = event: Signature sig Parameters? param Pre? pre  Post? post;

syntax Signature = eventsignature: EventName name "(" {EventArgument ","}* args")";
syntax EventArgument = eventargument: Type t Var var ("=" Expr exp)?;

syntax Parameters = "parameters" ":" Arguments args;
syntax Pre = "preconditions" ":" {Cond ","}* preconditions;
syntax Post = "postconditions" ":" {Cond ","}* postconditions;


syntax Cond =
	expression: Expr
	| multipleEventCalls: "(" Cond "|" Var "\<-" Expr ")"
	| eventcall: EventName "(" ExprList ")" "[" ExprList "]"
	;

syntax ExprList = {Expr ","}* exprs;