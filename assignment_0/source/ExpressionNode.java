/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

public class ExpressionNode implements Node {
	public Node left;
	public String operator;
	public Node right;

	public Object visit(Visitor v) {
		return v.visitExpression(this);
	}

	@Override
	public String toTree() {
		return String.format("Expression(left=%s, op=%s, right=%s)",
				left.toTree(), operator != null ? operator : "<NONE>",
				right != null ? right.toTree() : "<NONE>");
	}
}