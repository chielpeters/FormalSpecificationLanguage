package lang.specifications.alloy.com.spec;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.eclipse.imp.pdb.facts.ISourceLocation;
import org.eclipse.imp.pdb.facts.IString;
import org.eclipse.imp.pdb.facts.IValueFactory;

import lang.specifications.alloy.com.spec.Event;
import lang.specifications.alloy.com.spec.Alloy;

import com.google.gson.Gson;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.ConstList;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4.SafeList;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Decl;
import edu.mit.csail.sdg.alloy4compiler.ast.Expr;
import edu.mit.csail.sdg.alloy4compiler.ast.ExprVar;
import edu.mit.csail.sdg.alloy4compiler.ast.Func;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Tuple;
import edu.mit.csail.sdg.alloy4compiler.translator.A4TupleSet;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;

public class Traces {

	private static String sigName;
	private IValueFactory vf;

	public Traces(IValueFactory vf){
		sigName = "";
		this.vf = vf;
	}
	
	
	 public IString generateTrace(ISourceLocation fileLoc){
        A4Reporter rep = new A4Reporter();
        {
        	String loc = Alloy.getRoot()+fileLoc.getPath();
            Module world;
			try {
				world = CompUtil.parseEverything_fromFile(rep, null,loc );
            A4Options opt = new A4Options();
            opt.originalFilename = Alloy.getRoot()+fileLoc;
            opt.solver = A4Options.SatSolver.SAT4J;
            opt.skolemDepth=4;
            
            String tmp = fileLoc.getPath();
            sigName = tmp.substring(tmp.lastIndexOf("/")+1, tmp.lastIndexOf("."));
            
            
            Command cmd = world.getAllCommands().get(0);
            A4Solution sol = TranslateAlloyToKodkod.execute_command(rep, world.getAllReachableSigs(), cmd, opt);
            Gson gson = new Gson();
            String json = "";
            assert sol.satisfiable();
            
            for(int run = 0 ;run < 10; run++){
            	sol = sol.next();
            	for(ExprVar a:sol.getAllAtoms())   { world.addGlobal(a.label, a); }
            	for(ExprVar a:sol.getAllSkolems()) { world.addGlobal(a.label, a); }

            	List<Event> res = new ArrayList<Event>();	
            	SafeList<Func> preds = getAllPredicates(world);

            	for(int i = 0; i < 4 ; i++){
            		for(Func pred : preds){
            			if(isTrue(pred,i,sol,world)) res.add(new Event(pred.label,eval(getAdditionalParameters(pred,i),sol,world)));
            		}
            	}

            	String tmp2 = gson.toJson(res);
            	json += tmp2;
            	if(run != 9){ json +=",";}

            }
            json = "{traces: [" + json + "]}";
        	return vf.string(json);
			} catch (Err e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}		
        return vf.string("");
	}
	
	
	private static boolean isTrue(Func pred, int i, A4Solution sol, Module world) throws Exception {

		if(pred.decls.size() >=2 && pred.decls.get(0).expr.type().toString().contains(sigName) && pred.decls.get(1).expr.type().toString().contains(sigName)) {
			String expression = pred.label + "[" + sigName + "$" + new Integer(i+1).toString() + "," + sigName + "$" + new Integer(i).toString();
			for(String param : getAdditionalParameters(pred,i)){expression += "," + param;}
			expression += "]";
			System.out.println(expression);
			return (boolean) sol.eval(CompUtil.parseOneExpression_fromString(world, expression));
			
		}
		return false;
	}

	  List<String> eval(List<String> params,A4Solution sol, Module world) throws Exception{
		List<String> res = new ArrayList<String>();
		for(String param : params){
			 String tmp = AtomToJson(param,sol,world);
			 res.add(tmp);
		}
		return res;
	}
	
	 static List<String> getAdditionalParameters(Func pred, int i){
		ConstList<Decl> decls = pred.decls;
		ArrayList<String> a = new ArrayList<String>();
		List<String> res = new ArrayList<String>();
		for(Decl decl : decls){
			a.add(Decl2ArgumentString(decl,a));
		}
		for(String elem : a){
			if(a.indexOf(elem) > 1){
				res.add(sigName + "$" + new Integer(i).toString() + "." + "$" + elem);
			}
		}
		return res;
	}
	
	 static SafeList<Func> getAllPredicates(Module world){
    	SafeList<Func> funcs = world.getAllFunc();
    	SafeList<Func> preds = new SafeList<Func>();
    	for(Func func : funcs){
    		if(func.isPred) preds.add(func);
    	}
    	return preds;
    }
	
	static String Decl2ArgumentString(Decl d, List<String> prevs){
		String arg = d.get().type().toString();
		arg = arg.substring(1, arg.length()-1);
		if(arg.contains("/")){
			arg = arg.substring(arg.lastIndexOf("/")+1);
		}
		arg = arg.substring(0, 1).toLowerCase();
		Integer i = 1;
		String res = arg;
		while(prevs.contains(res)){
			res = arg + i.toString();
			i++;
		}
		return res;
	}	

	String A4TupleSetToJson(A4TupleSet ts, A4Solution sol, Module world) throws Exception{
		String res = "{";
		Iterator<A4Tuple> it = ts.iterator();
		while(it.hasNext()){
			A4Tuple t = it.next();
			for(int i = 0 ; i<t.arity();i++){
				res += t.sig(i) + ":" + AtomToJson(t.atom(i),sol,world);
			}
		}
		return res + "}";
		
	}


	String AtomToJson(String atom, A4Solution sol, Module world) throws Exception {
		Expr e = CompUtil.parseOneExpression_fromString(world, atom);
		if(sol.eval(e) instanceof A4TupleSet){
			return A4TupleSetToJson((A4TupleSet)sol.eval(e),sol,world);
		}
		String tmp = sol.eval(e).toString();
		return tmp.substring(1, tmp.length()-1);
	}
}


