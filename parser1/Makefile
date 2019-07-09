
main: apocalypse.flex java-cup-11a.jar parser.cup ADriver.java test.asm
	java -jar java-cup-11a.jar -interface -parser AParser parser.cup 
	jflex apocalypse.flex
	javac -classpath .:java-cup-11a.jar ADriver.java

run: java-cup-11a.jar ADriver.class test.asm
	java -classpath .:java-cup-11a.jar ADriver test.asm



