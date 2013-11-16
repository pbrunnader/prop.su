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
        
        if (t.type() == Token.Type.IDENTIFIER && n.type() == Token.Type.EQ) {
        	    node.left = new IdentifierNode();
        	    node.left.value = t.text();
        	    tokenizer.next();
        	    node.right = this.parseExpression();
        } else {
        	    throw new RuntimeException("parse(): No valid 'IDENTIFIER' or 'EQ' given!");
        }
        return node;
    }

	private Node parseExpression() {
		ExpressionNode node = new ExpressionNode();
		node.left = parseTerm();
        if (tokenizer.current().type() == Token.Type.PLUS || tokenizer.current().type() == Token.Type.MINUS) {
		    node.operator = tokenizer.current().text();
            tokenizer.next();
            node.right = parseTerm();
        }
        return node;
	}

	private Node parseTerm() {
		TermNode node = new TermNode();
		node.left = parseFactor();
        if (tokenizer.current().type() == Token.Type.MULT || tokenizer.current().type() == Token.Type.DIV) {
            node.operator = tokenizer.current().text();
            tokenizer.next();
            node.right = parseFactor();
        }
		return node;
	}

	private Node parseFactor() {
		FactorNode node = new FactorNode();
		if(tokenizer.current().type() == Token.Type.LEFT_PAREN) {
             tokenizer.next();
			node.node = parseExpression();
		} else if (tokenizer.current().type() == Token.Type.NUMBER) {
			node.node = parseNumber();
        }
        if (tokenizer.current().type() == Token.Type.RIGHT_PAREN) {
            tokenizer.next();
		}
		return node;
	}
	
	private Node parseNumber() {
		NumberNode node = new NumberNode();
		node.value = tokenizer.current().value();
        tokenizer.next();
		return node;		
	}

}