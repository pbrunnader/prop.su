/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

import java.io.IOException;
import java.io.StringReader;

class YourScannerImpl implements Scanner {
	
	private StringReader scanner;
	private Boolean first = true;
	
    public YourScannerImpl(StringReader reader) {
        this.scanner = reader;
        try {
			this.scanner.mark(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * Return the current character in the stream
     *
     */
    public char current() {
    	char current = 0;
    	try {
    		scanner.reset();
			current = (char) scanner.read();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return current;
    }

    /**
     * Return the next character in the stream. Subsequent calls to
     * current() will return the same character. Scanner.EOF is return
     * if the end of the file is reached.
     *
     */
    public char next() {
    	char next = 0;
    	
    	try {
    		do {
        		scanner.reset();
	    		if(!this.first)
	    			scanner.read();
	    		this.first = false;
	    		scanner.mark(1);
	    		if(scanner.read() == -1 )
	    			return Scanner.EOF;
	    		scanner.reset();
    			next = (char) scanner.read();
    		}while(Character.isWhitespace(next));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return next;
    }


    /**
     * Return the next character in the stream. Subsequent calls to
     * next() will return the same character, but calls to current()
     * will be unaffected.
     *
     */
    public char peek() {
    	char peek = 0;
    	
    	try {
			scanner.reset();
			scanner.read();
    		do {
    			peek = (char) scanner.read();
    		}while(Character.isWhitespace(peek));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return peek;
    }

}