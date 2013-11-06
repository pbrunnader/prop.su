
public interface Tokenizer {
	/**
	 * Return the current token in the stream
	 *
	 */
	Token current();
	
	/**
	 * Return the current token in the stream
	 * 
	 */
	Token next();

	/**
	 * Return the next token in the stream, but don't move current()
	 * to next()
	 *
	 */
	Token peek();
}