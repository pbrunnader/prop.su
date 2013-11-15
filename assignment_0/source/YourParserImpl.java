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
        System.out.println("new assign node created.");
        Token t = tokenizer.next();
        Token n = tokenizer.next();
        
        if(t.type() == Token.Type.IDENTIFIER && n.type() == Token.Type.EQ) {
        	node.left = new IdentifierNode();
        	node.left.value = t.text();
        	System.out.println("new idNode created: " + node.left.value);
        	
        	tokenizer.next();
        	node.right = this.parseExpression();
        	
        	
        } else {
        	
        	throw new RuntimeException("ERROR");
        }
        return node;
    }

	private Node parseExpression() {
		ExpressionNode node = new ExpressionNode();
		node.left = parseTerm();
		node.operator = tokenizer.current().text();
		System.out.println("new expression node created: " + node.operator);
		node.right = parseTerm();
		return node;
	}

	private Node parseTerm() {
		TermNode node = new TermNode();
		//node.operator = tokenizer.current().text();
		//System.out.println("new term node created: " + node.operator);
		node.left = parseFactor();
		node.operator = tokenizer.next().text();
		System.out.println("new term node created: " + node.operator);
		node.right = parseFactor();
		return node;
	}

	private Node parseFactor() {
		FactorNode fNode = new FactorNode();
		System.out.println("new factor node created");
		if(tokenizer.current().type() == Token.Type.LEFT_PAREN ) {
			return this.parseExpression();
		} else if ( tokenizer.current().type() == Token.Type.NUMBER ) {
			return parseNumber();
		}
		return fNode;
	}
	
	private Node parseNumber() {
		NumberNode node = new NumberNode();
		node.value = tokenizer.current().value();
		System.out.println("new number node created: " + node.value.toString());
		return node;
		
	}

}