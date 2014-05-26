module lang::specifications::ide::Specifications

import lang::specifications::\syntax::Specifications;
import lang::specifications::check::Specifications;
import lang::specifications::alloy::Specifications;
import lang::specifications::utils::Parse;
import util::IDE;
import Message;
import ParseTree;
import List;


str SPECIFICATION_EXTENSION = "spec";
str SPECIFICATION_LANGUAGE = "Specification";

void registerSpecifications(){
	registerLanguage(SPECIFICATION_LANGUAGE,SPECIFICATION_EXTENSION,parseSpecification);
	registerAnnotator(SPECIFICATION_LANGUAGE, checkAndAnnotate);
	contribs = {
	popup(
		menu(SPECIFICATION_LANGUAGE,[
	    	action("Generate Alloy", generateAlloy),
	    	action("Generate and Start Alloy", generateAndStartAlloy)
		])
	)
	};
	registerContributions(SPECIFICATION_LANGUAGE, contribs);
}

Specification checkAndAnnotate(Specification spec){
	return spec[@messages = toSet(check(spec))];
}

void generateAlloy(Specification spec, loc l){
	specification2alloy(spec,false);
}

void generateAndStartAlloy(Specification spec, loc l){
	generateAlloy(sa,l);
	loc alloyLoc = |project://FormalSpecificationLanguage/resources/Alloy4.2_2014-05-16.jar|;
	loc location = |project://FormalSpecificationLanguage/output/| + "<sa.name>.als";
	startAlloy(alloyLoc,location);
	
}

@javaClass{lang.specifications.alloy.com.spec.Alloy}
public java void startAlloy(loc jarLoc,loc l);

@javaClass{lang.specifications.alloy.com.spec.Alloy}
public java str getString(loc l);