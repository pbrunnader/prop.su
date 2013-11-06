

public interface Scanner {
	public static final char EOF = (char)0;
	public static final char EOL = '\n';
	
	/**
	 * Return the current character in the stream
	 *
	 */
	char current();

	/**
	 * Return the next character in the stream. Subsequent calls to
	 * current() will return the same character. Scanner.EOF is return
	 * if the end of the file is reached.
	 *
	 */
	char next();


	/**
	 * Return the next character in the stream. Subsequent calls to
	 * next() will return the same character, but calls to current()
	 * will be unaffected.
	 *
	 */
	char peek();
}