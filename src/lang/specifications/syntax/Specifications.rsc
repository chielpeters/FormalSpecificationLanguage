module lang::specifications::\syntax::Specifications

extend lang::specifications::\syntax::Expressions;
extend lang::specifications::\syntax::Lexical;
extend lang::events::\syntax::Events;
extend lang::invariants::\syntax::Invariants;

start syntax Specification = "Specification" ClassName name EventInstances evs InvariantInstances? invs;

syntax EventInstances = "Events" "{" EventInstance* events "}";
syntax EventInstance = EventName name "(" ExprList el ")";

syntax InvariantInstances = "Invariants" "{" InvariantInstance* invariants "}";
syntax InvariantInstance = InvariantName name;
