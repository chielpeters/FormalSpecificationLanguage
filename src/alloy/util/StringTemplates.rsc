module alloy::util::StringTemplates

import grammar::SavingsAccount;

str getModuleName(SavingsAccountName sn) = "module <sn>\n";

str getImports(){
return "
	'open util/ordering[SavingsAccount]
	'open util/integer
	'open date
	'open period
	'open frequency
	'open percentage
\n";
}

str getSignature(){
return "sig SavingsAccount {
	'  balance : Date -\> lone Int,
	'  term  : one Int,
	'  startDate : one Date,
	'  payoutfreq: one Frequency,
	'  opened : lone Int,
	'  now : one Date
	'}{
	'  opened in {0+1}
	'  all d : prevs[now] + now | d in balance.Int
	'}
	'\n";
}


str addComment(str com) = "// <com> \n";
str addMLComment(str com) = "/********************\n* <com>\n********************/\n\n";