module grammar::SavingsAccount

extend grammar::Expressions;
extend grammar::Events;
extend grammar::Lexical;

start syntax SavingsAccount = "SavingsAccount" SavingsAccountName name IEvent+ events;
syntax IEvent = EventName name "(" ExprList exprlist ")";