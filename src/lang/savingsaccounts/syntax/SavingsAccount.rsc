module lang::savingsaccounts::\syntax::SavingsAccount

extend lang::savingsaccounts::\syntax::Expressions;
extend lang::savingsaccounts::\syntax::Lexical;
extend lang::events::\syntax::Events;
extend lang::invariants::\syntax::Invariants;

start syntax SavingsAccount = "SavingsAccount" SavingsAccountName name EventInstances evs InvariantInstances? invs;

syntax EventInstances = "Events" "{" EventInstance* events "}";
syntax EventInstance = EventName name "(" ExprList el ")";

syntax InvariantInstances = "Invariants" "{" InvariantInstance* invariants "}";
syntax InvariantInstance = InvariantName name;
