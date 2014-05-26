module lang::events::alloy::Events

import lang::events::\syntax::Events;
import lang::events::alloy::properties::Fields;
import lang::specifications::\syntax::Fields;
import lang::specifications::alloy::utils::Info;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::alloy::Expressions;
import lang::functions::alloy::Functions;
import List;
import String;

str event2alloy(Event e,FieldDecls fs, Info i){
	str event = "pred <i.specname>.<e.sig.name> [ old : <i.specname> <(/Parameters p := e.param) ? ","+functionargs2alloy(p.args):"">]{
	'  <(/Pre pre := e.pre) ? addComment("PRECONDITIONS")+precond2alloy(pre,i):"">
	'  <(/Post post := e.post) ? addComment("POSTCONDITIONS")+postcond2alloy(post,i):"">
	'  <notchangedfields2alloy(e,fs,"old","this")>
	'}\n\n";
	
	return event;
}

str precond2alloy(Pre pre,Info i) = intercalate(" \n", [ expr2alloy(cond, i.vm+oldNow()) | cond <- pre.preconditions.exprs ]);
str postcond2alloy(Post post,Info i) = intercalate(" \n", [ expr2alloy(cond,i.vm) | cond <- post.postconditions.exprs ]);