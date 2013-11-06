public class AssignNode implements Node {
	public Node left;
	public Node right;

	public Object visit(Visitor v) {
		return v.visitAssign(this);
	}

	@Override
	public String toTree() {
		return String.format("Assign(left=%s, right=%s)", left.toTree(),
				right.toTree());
	}
}