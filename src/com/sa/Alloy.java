package com.sa;

import java.io.IOException;

import org.eclipse.imp.pdb.facts.IString;
import org.eclipse.imp.pdb.facts.IValue;
import org.eclipse.imp.pdb.facts.IValueFactory;

public class Alloy {
	
    private final IValueFactory vf;
    public Alloy(IValueFactory vf) { 
      this.vf = vf;
    }
	
	public void startAlloy(IString s){
		String cmd = "java -jar C:/Users/Chiel/Dropbox/Thesis/Alloy/alloy4.2.jar " + s.getValue();
		try {
			Runtime.getRuntime().exec(cmd);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
    IValue myFunction(IString x) {
        return vf.integer(-1);
     }
}
