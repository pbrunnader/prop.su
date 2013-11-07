/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

import java.io.StringReader;

class YourScannerImpl implements Scanner {
    
    public YourScannerImpl(StringReader reader) {
        
    }
    
    /**
     * Return the current character in the stream
     *
     */
    public char current() {
        return Character.valueOf('\u0000');
    }

    /**
     * Return the next character in the stream. Subsequent calls to
     * current() will return the same character. Scanner.EOF is return
     * if the end of the file is reached.
     *
     */
    public char next() {
        return Character.valueOf('\u0000');
    }


    /**
     * Return the next character in the stream. Subsequent calls to
     * next() will return the same character, but calls to current()
     * will be unaffected.
     *
     */
    public char peek() {
        return Character.valueOf('\u0000');
    }

}