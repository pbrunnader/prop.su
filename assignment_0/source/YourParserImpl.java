/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 */

class YourParserImpl implements Parser {
	
	private Tokenizer tokenizer;
	
    public YourParserImpl(Tokenizer to) {
        this.tokenizer = to;
    }
    
    public Node parse() {
        AssignNode node = new AssignNode();

        Token t = tokenizer.next();
        Token n = tokenizer.next();
        
        if(t.type() == Token.Type.IDENTIFIER && n.type() == Token.Type.EQ) {
        	node.left = new IdentifierNode();
        	node.left.value = t.text();
        	
        	tokenizer.next();
        	node.right = this.parseExpression();
        	
        	
        } else {
        	
        	throw new RuntimeException("ERROR");
        }
        return node;
    }

	private Node parseExpression() {
		parseTerm();
		return null;
	}

	private Node parseTerm() {
		
		parseFactor();
		return null;
	}

	private Node parseFactor() {
		if(tokenizer.current().type() == Token.Type.LEFT_PAREN ) {
			return this.parseExpression();
		} else if ( tokenizer.current().type() == Token.Type.NUMBER ) {
			NumberNode node = new NumberNode();
			node.value = tokenizer.current().value();
			System.out.println("new number node created: " + node.value.toString());
			return node;
		}
		return null;
	}

}