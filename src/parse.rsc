module parse

import vis::Figure;
import vis::ParseTree;
import vis::Render;
import ParseTree;

public void viewTree(Tree tree) = render(space(visParsetree(tree),std(gap(8,30)),std(resizable(true))));