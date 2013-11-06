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