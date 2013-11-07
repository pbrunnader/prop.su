/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

public class Visitor {

	public Object visit(Node node) {
		if(node != null) {
			return node.visit(this);
		}
		return null;
	}

	public Object visitAssign(AssignNode n) {
		return null;
	}

	public Object visitExpression(ExpressionNode n) {
		return null;
	}

	public Object visitTerm(TermNode n) {
		return null;
	}

	public Object visitFactor(FactorNode n) {
		return null;
	}

	public Object visitIdentifier(IdentifierNode n) {
		return null;
	}

	public Object visitNumber(NumberNode n) {
		return null;
	}
}