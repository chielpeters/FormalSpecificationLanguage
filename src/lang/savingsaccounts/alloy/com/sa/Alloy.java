package lang.savingsaccounts.alloy.com.sa;

import java.io.IOException;

import org.eclipse.imp.pdb.facts.ISourceLocation;
import org.eclipse.imp.pdb.facts.IValueFactory;

public class Alloy {
	
	@SuppressWarnings("unused")
    private final IValueFactory vf;
    public Alloy(IValueFactory vf) { 
      this.vf = vf;
    }
	public void startAlloy(ISourceLocation l){
		String cmd = "java -jar C:/Users/Chiel/Dropbox/Thesis/Alloy/alloy4.2.jar " + l.toString();
		try {
			Runtime.getRuntime().exec(cmd);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
