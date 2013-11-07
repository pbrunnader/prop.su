/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

public interface Parser {

	/**
	 * Parse, using a tokenizer (supplied as a contructor parameter),
	 * a parse tree
	 *
	 */
	Node parse();
}