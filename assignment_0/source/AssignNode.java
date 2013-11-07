/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

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