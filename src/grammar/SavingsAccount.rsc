module grammar::SavingsAccount

extend grammar::Expressions;
extend grammar::Events;
extend grammar::Lexical;
extend grammar::Invariants;

start syntax SavingsAccount = "SavingsAccount" SavingsAccountName name I_Events evs I_Invariants? invs;

syntax I_Events = "Events" "{" I_Event* events "}";
syntax I_Invariants = "Invariants" "{" I_Invariant* invariants "}";

syntax I_Invariant = InvariantName name;
syntax I_Event = EventName name "(" ExprList el ")";