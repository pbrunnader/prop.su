public class NumberNode implements Node {
	public Number value;

	public Object visit(Visitor v) {
		return v.visitNumber(this);
	}

	@Override
	public String toTree() {
		return String.format("Number(value=%s)", value.toString());
	}
}