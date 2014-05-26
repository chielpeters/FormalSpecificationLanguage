module lang::events::\syntax::Events

extend lang::functions::\syntax::Functions;
extend lang::specifications::\syntax::Expressions;
extend lang::specifications::\syntax::Lexical;

start syntax Events = events: Event* events;

syntax Event = @Foldable event: LifeCycleType? lct Signature sig Parameters? param Pre? pre  Post? post;

syntax Signature = eventsignature: EventName name "(" {EventArgument ","}* args")";
syntax EventArgument = eventargument: Type t Var var ("=" Expr exp)?;

syntax Parameters = "parameters" ":" Arguments args;
syntax Pre = "preconditions" ":" ExprList preconditions;
syntax Post = "postconditions" ":" ExprList postconditions;

syntax LifeCycleType = "initial" | "final";
