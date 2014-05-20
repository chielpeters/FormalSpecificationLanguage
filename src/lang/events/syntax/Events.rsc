module lang::events::\syntax::Events

extend lang::functions::\syntax::Functions;
extend lang::savingsaccounts::\syntax::Expressions;
extend lang::savingsaccounts::\syntax::Lexical;

start syntax Events = events: Event* events;

syntax Event = @Foldable event: Signature sig Parameters? param Pre? pre  Post? post;

syntax Signature = eventsignature: EventName name "(" {EventArgument ","}* args")";
syntax EventArgument = eventargument: Type t Var var ("=" Expr exp)?;

syntax Parameters = "parameters" ":" Arguments args;
syntax Pre = "preconditions" ":" {Cond ","}* preconditions;
syntax Post = "postconditions" ":" {Cond ","}* postconditions;


syntax Cond =
	expression: Expr
	| multipleEventCalls: "(" Cond!multipleEventCalls "|" Var "\<-" Expr ")"
	| eventcallWithArgs: EventName "(" ExprList ")" "[" ExprList "]"
	;

