import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

public class Test {

	public static void main(String[] args) throws Exception {
		String[] exprs = new String[] { "a = 1 + 2", "b= 1+ 2", "c=1*2+11/2", "d=(2+3)-(10*(20-3))" };
		Object[] expecteds = new Object[] { new Object[] { "a", 3 },
				new Object[] { "b", 3 }, new Object[] { "c", 7 }, new Object[] {"d", -165}};

		for (int n = 0; n < exprs.length; n++) {
			String expr = exprs[n];
			Object[] expected = (Object[]) expecteds[n];

			Scanner sc = new YourScannerImpl(new StringReader(expr));
			Tokenizer to = new YourTokenizerImpl(sc);
			Parser pa = new YourParserImpl(to);
			Node root = pa.parse();
//			System.out.println(expr);
//			System.out.println(root.toTree());

			Visitor v = new Visitor();

			@SuppressWarnings("unchecked")
			Map<String, Number> observed = (Map<String, Number>) v.visit(root);
			System.out.println(observed);
			System.out.println("Evaluated: '" + expr + "' Expected: '"
					+ expected[0] + "'='" + expected[1] + "' Got: '"
					+ observed.get(expected[0]) + "'");
		}

	}
}