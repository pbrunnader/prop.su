/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

public class NumberNode implements Node {
	public Object value;

	public Object visit(Visitor v) {
		return v.visitNumber(this);
	}

	@Override
	public String toTree() {
		return String.format("Number(value=%s)", value.toString());
	}
}