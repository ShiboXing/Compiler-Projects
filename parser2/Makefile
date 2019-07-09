
main: MiniJavaLexer.flex MiniParser.cup 
	jflex MiniJavaLexer.flex
	java -jar java-cup-11a.jar -interface -parser MParser MiniParser.cup
	javac -classpath .:java-cup-11a.jar MDriver.java

run: java-cup-11a.jar test.java 
	java -classpath .:java-cup-11a.jar MDriver test.java

