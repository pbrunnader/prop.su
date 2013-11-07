/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

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