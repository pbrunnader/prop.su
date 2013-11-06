public interface Parser {

	/**
	 * Parse, using a tokenizer (supplied as a contructor parameter),
	 * a parse tree
	 *
	 */
	Node parse();
}