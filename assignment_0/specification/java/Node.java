public interface Node {
	Object visit(Visitor visitor);

	String toTree();
}