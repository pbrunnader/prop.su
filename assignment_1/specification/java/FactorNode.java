public class FactorNode implements Node {
	public Node node; // IdentifierNode, FactorNode or ExpressionNode

	public Object visit(Visitor v) {
		return v.visitFactor(this);
	}

	@Override
	public String toTree() {
		return String.format("Factor(node=%s)", node.toTree());
	}

}