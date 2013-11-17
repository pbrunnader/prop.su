/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

import java.util.HashMap;
import java.util.Map;

public class Visitor {

	public Object visit(Node node) {
		if(node != null) {
			return node.visit(this);
		}
		return null;
	}

	public Object visitAssign(AssignNode n) {
        Map<String, Number> assignments = new HashMap<String, Number>();
        String left = (String) visitIdentifier(n.left);
        Number right = (Number) visitExpression((ExpressionNode) n.right);
		assignments.put(left, right);
        return assignments;
	}

	public Object visitExpression(ExpressionNode n) {
        if(n.operator != null && Token.Type.OPERATORS.get(n.operator).equals(Token.Type.PLUS)) {
            if(n.right instanceof ExpressionNode)
                return ((Integer) visitTerm((TermNode) n.left)) + ((Integer) visitExpression((ExpressionNode) n.right));
            return ((Integer) visitTerm((TermNode) n.left)) + ((Integer) visitTerm((TermNode) n.right));
        } else if(n.operator != null && Token.Type.OPERATORS.get(n.operator).equals(Token.Type.MINUS)) {
            if(n.right instanceof ExpressionNode)
                return ((Integer) visitTerm((TermNode) n.left)) - ((Integer) visitExpression((ExpressionNode) n.right));
            return ((Integer) visitTerm((TermNode) n.left)) - ((Integer) visitTerm((TermNode) n.right));
        }
        return ((Integer) visitTerm((TermNode) n.left));
	}

	public Object visitTerm(TermNode n) {
        if(n.operator != null && Token.Type.OPERATORS.get(n.operator).equals(Token.Type.MULT)) {
            if(n.right instanceof TermNode)
                return ((Integer) visitFactor((FactorNode) n.left)) * ((Integer) visitTerm((TermNode) n.right));
            return ((Integer) visitFactor((FactorNode) n.left)) * ((Integer) visitFactor((FactorNode) n.right));
        } else if(n.operator != null && Token.Type.OPERATORS.get(n.operator).equals(Token.Type.DIV)) {
            if(n.right instanceof TermNode)
                return ((Integer) visitFactor((FactorNode) n.left)) / ((Integer) visitTerm((TermNode) n.right));
            return ((Integer) visitFactor((FactorNode) n.left)) / ((Integer) visitFactor((FactorNode) n.right));
        }
        return ((Integer) visitFactor((FactorNode) n.left));
	}

	public Object visitFactor(FactorNode n) {
        if(n.node instanceof ExpressionNode) {
            return ((Integer) visitExpression((ExpressionNode) n.node));
        } 
        return ((Integer) visitNumber((NumberNode) n.node));
	}

	public Object visitIdentifier(IdentifierNode n) {
		return n.value;
	}

	public Object visitNumber(NumberNode n) {
		return (Integer) n.value;
	}
}