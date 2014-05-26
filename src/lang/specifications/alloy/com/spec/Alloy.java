package lang.specifications.alloy.com.spec;


import java.io.IOException;


import org.eclipse.imp.pdb.facts.ISourceLocation;
import org.eclipse.imp.pdb.facts.IString;
import org.eclipse.imp.pdb.facts.IValueFactory;

public class Alloy {
	
    private final IValueFactory vf;
    public Alloy(IValueFactory vf) { 
      this.vf = vf;
    }
	public void startAlloy(ISourceLocation jarLoc, ISourceLocation l){
		String cmd = "java -jar " + getRoot() + jarLoc.getPath() + " " + getRoot() + l.getPath();
		System.out.println(cmd);
		try {
			Runtime.getRuntime().exec(cmd);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public IString getString(ISourceLocation l){
		return vf.string( getRoot() + l.getPath());
	}
	
	public static String getRoot(){
		return "C:/Users/Chiel/Dropbox/Thesis/SavingsAccount";
	}
}
