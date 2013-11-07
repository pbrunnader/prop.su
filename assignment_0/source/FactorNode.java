/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

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