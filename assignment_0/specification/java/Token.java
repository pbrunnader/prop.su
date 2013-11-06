import java.util.*;

public class Token {
	public enum Type {
		IDENTIFIER, NUMBER, EOF, PLUS, MINUS, MULT, DIV, EQ, LEFT_PAREN, RIGHT_PAREN;

		public static Map<String, Token.Type> OPERATORS = null;
		static {
			Map<String, Token.Type> types = new HashMap<String, Token.Type>();
			types.put("+", Token.Type.PLUS);
			types.put("-", Token.Type.MINUS);
			types.put("*", Token.Type.MULT);
			types.put("/", Token.Type.DIV);
			types.put("=", Token.Type.EQ);
			types.put("(", LEFT_PAREN);
			types.put(")", RIGHT_PAREN);

			OPERATORS = Collections
					.unmodifiableMap(new HashMap<String, Token.Type>(types));
		}
	}

	private String text;
	private Object value;
	private Token.Type type;

	public Token(String text, Object value, Token.Type type) {
		this.text = text;
		this.value = value;
		this.type = type;
	}

	public Object value() {
		return value;
	}

	public String text() {
		return text;
	}

	public Token.Type type() {
		return type;
	}
}