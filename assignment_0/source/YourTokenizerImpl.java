/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

class YourTokenizerImpl implements Tokenizer {
	
	private Scanner scanner;
	private Token current = null;
	private Token peek = null;
	
	
    public YourTokenizerImpl(Scanner sc) {
        this.scanner = sc;
        // this.current = extractToken();
        this.peek = extractToken();
    }
    
    private Token extractToken() {
    	char ch = scanner.next();
    	if(ch == Scanner.EOF) {
    		System.out.println("EOF");
    		return new Token(String.valueOf(ch), String.valueOf(ch), Token.Type.EOF);
    		
    	}
    	if(Character.isDigit(ch)) {
    		return extractNumber();
    		
    		
    	} else if (Token.Type.OPERATORS.containsKey(String.valueOf(ch))) {
    		Token t = new Token(String.valueOf(ch), String.valueOf(ch), Token.Type.OPERATORS.get(String.valueOf(ch)));
    		ch = scanner.current();
    		return t;
    		
    	} else if (Character.isLetter(ch)) {
    		return extractIdentifier();
    		
    	} else {
    		throw new RuntimeException("Unexpected character...");
    		
    	}
    	
    	
    }
        
    private Token extractIdentifier() {
    	System.out.println("extract id");
    	String identifier = String.valueOf(scanner.current());
    	
    	while(Character.isLetter(scanner.peek())) {
    		identifier += String.valueOf(scanner.next());
    	}
    	Token t = new Token(identifier, identifier, Token.Type.IDENTIFIER );
    	System.out.println("token: " + t.value());
		return t;
	}

	private Token extractNumber() {
    	String number = String.valueOf(scanner.current());
    	
    	while(Character.isDigit(scanner.peek())) {
    		number += String.valueOf(scanner.next());
    	}
		return new Token(number, Integer.parseInt(number), Token.Type.NUMBER);
	}

	/**
     * Return the current token in the stream
     *
     */
    public Token current() {
    	if( current == null )
    		return peek;
        return current;
    }
            
    /**
     * Return the current token in the stream
     * 
     */
    public Token next() {
    	current = peek;
    	System.out.println("current: " + current.toString() );
    	peek = extractToken();
    	System.out.println("peek: " + peek.toString());
    	return current;
    }

    /**
     * Return the next token in the stream, but don't move current()
     * to next()
     *
     */
    public Token peek() {
        return peek;
    }

}