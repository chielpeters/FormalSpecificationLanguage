module lang::specifications::\syntax::Specifications

extend lang::specifications::\syntax::Expressions;
extend lang::specifications::\syntax::Lexical;
extend lang::specifications::\syntax::Fields;
extend lang::events::\syntax::Events;
extend lang::invariants::\syntax::Invariants;

start syntax Specification = 
	Imports imports "Specification" SpecificationName name Extends? ext Fields fields EventInstances evs InvariantInstances? invs;

syntax Extends = "extends" SpecificationName name;
 
syntax Fields =  @Foldable "Fields" "{" FieldDecls fields "}";

syntax EventInstances =  @Foldable "Events" "{" EventInstance* events "}";
syntax EventInstance = EventName name "(" ExprList el ")";

syntax InvariantInstances =  @Foldable "Invariants" "{" InvariantInstance* invariants "}";
syntax InvariantInstance = InvariantName name;

syntax Imports = Import* imports;
syntax Import = "import" FileName filename;
