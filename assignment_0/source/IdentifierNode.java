/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

public class IdentifierNode implements Node {
	public String value;

	public Object visit(Visitor v) {
		return v.visitIdentifier(this);
	}

	@Override
	public String toTree() {
		return String.format("Identifier(value=%s)", value);

	}
}