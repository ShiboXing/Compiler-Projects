import java.io.FileReader;
import java.util.ArrayList;
import java.util.Iterator;

import syntaxtree.*;
import visitor.PrettyPrintVisitor;
import java_cup.runtime.Symbol;

public class MDriver
{
    static Program program;
    public static void main(String[] args)
    {

            if(args.length != 1) 
            {
                System.err.println("Usage: java MDriver test.java"); System.exit(1);
            }        
            try 
            {
                {PrettyPrintVisitor ppv=new PrettyPrintVisitor();
                MParser parser = new MParser(new MLexer( new FileReader(args[0])));
                program=(Program)parser.parse().value;
                program.accept(ppv);}
            }
            catch (java.io.IOException e) 
            {
                System.err.println("Unable to open file: " + args[0]); 
            } 
            catch (Exception e) 
            {
                e.printStackTrace(System.err);
            }

           
    }
}