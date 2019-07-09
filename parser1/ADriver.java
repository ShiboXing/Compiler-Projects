
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Random;

import java_cup.runtime.Symbol;


public class ADriver
{
    
    static ArrayList op_list;
    static Hashtable<String,Integer> labels;
    static byte[] Regs;
    static byte[] RAM;
    static int pc;


    public static void main(String args[])
    {
        
        if(args.length != 1) 
        {
            System.err.println("Usage: java ADriver file.asm"); System.exit(1);
        }        
        try 
        {
            AParser parser = new AParser(new Apocalypse( new FileReader(args[0])));
            op_list=(ArrayList)parser.parse().value;
        } 
        catch (java.io.IOException e) 
        {
            System.err.println("Unable to open file: " + args[0]); 
        } 
        catch (Exception e) 
        {
            e.printStackTrace(System.err);
        }
        
        RAM=new byte[256];
        Regs=new byte[4];
        labels=new Hashtable<String,Integer>();
        interpret();

    }

    public static void interpret()
    {
        
        int count=0;
        //HASH AND STORE ALL THE LABELS
        for(int g=0;g<op_list.size();g++)
        {
            Object o=op_list.get(g);
            String[] find=((String)o).split(",");
            if(Integer.parseInt(find[0])==sym.LABEL)
            {
               
                if(labels.get(find[1])!=null)
                {
                    System.out.println("============\n============\nduplicated label:+"+find[1]+"\n\n\n");
                    System.exit(0);
                }
                
                labels.put(find[1],new Integer(g));
                op_list.remove(g--);
                //System.out.println("labels["+find[1]+"]:  "+op_list.get(labels.get(find[1])));
            }   
            
            count++;
        }

        //START INTERPRETING
        while(true)
        {
            Object o=op_list.get(pc++);
            //System.out.println((String)o);
            String[] tmp=((String)o).split(",");
            int[] op=new int[tmp.length];
            int oc=Integer.parseInt(tmp[0]);
            if(oc==sym.LABEL)
                continue;
            if(oc==sym.J)
            {
                op[0]=oc;
                
                if(labels.get(tmp[1])==null)
                {
                    System.out.println("============\n============\ninvalid label: "+tmp[1]+"\n\n\n");
                    System.exit(0);
                }
                else
                    op[1]=labels.get(tmp[1]).intValue();
                
            }
            else
            {
                for(int i =0; i<tmp.length;i++)
                {
                    op[i]=Integer.parseInt(tmp[i]);
                }
            }
            
            switch(op[0])
            {
                case sym.ADD: 
                    
                    if(Regs[op[2]]+Regs[op[3]]>255 || Regs[op[2]]+Regs[op[3]]<-128)
                    {
                        System.out.println("============\n============\nresgiter "+op[1]+" overflowed, exited\n\n\n");
                        System.exit(0);
                    }
                    Regs[op[1]]=(byte)(Regs[op[2]]+Regs[op[3]]);
                    break;

                case sym.SUB:
                    if(Regs[op[2]]-Regs[op[3]]>255 || Regs[op[2]]-Regs[op[3]]<-128)
                    {
                        System.out.println("============\n============\nresgiter "+op[1]+" overflowed, exited\n\n\n");
                        System.exit(0);
                    }
                    Regs[op[1]]=(byte)(Regs[op[2]]-Regs[op[3]]);
                    break;

                case sym.XOR:
                    Regs[op[1]]=(byte)(Regs[op[2]]^Regs[op[3]]);
                    break;

                case sym.SLT:
                    if(Regs[op[2]]<Regs[op[3]])
                        Regs[op[1]]=1;
                    else
                        Regs[op[1]]=0;
                    break;

                case sym.ADDI:
                    if(Regs[op[2]]+op[3]>255 || Regs[op[2]]+op[3]<-128)
                    {
                        System.out.println("============\n============\nresgiter "+op[1]+" overflowed, exited\n\n\n");
                        System.exit(0);
                    }
                    Regs[op[1]]=(byte)(Regs[op[2]]+op[3]);
                    break;

                case sym.RAND:
                    Random rand=new Random();
                    Regs[op[1]]=(byte)rand.nextInt(op[2]);
                    break;
                
                case sym.SB:
                    if(op[2]+Regs[op[3]]>255 || op[2]+Regs[op[3]]<-128)
                    {
                        System.out.println("============\n============\nMemory index out of bound, exited\n\n\n");
                        System.exit(0);
                    }
                    RAM[op[2]+Regs[op[3]]]=Regs[op[1]];
                    break;
                
                case sym.LB:
                    if(op[2]+Regs[op[3]]>255 || op[2]+Regs[op[3]]<-128)
                    {
                        System.out.println("============\n============\nMemory index out of bound, exited\n\n\n");
                        System.exit(0);
                    }
                    Regs[op[1]]=(RAM[(op[2]+Regs[op[3]])]);
                    break;

                case sym.J:
                    pc=op[1];
                    break;
                
                case sym.BEQ:
                    if(Regs[op[1]]==Regs[op[2]])
                        pc += op[3]-1;
                    break;

                case sym.DISP:
                    String result=Integer.toHexString(Regs[op[1]]);
                    if(result.length()>2)
                        result=result.substring(result.length()-2,result.length());
                    System.out.println(result);
                    break;

                case sym.HALT: 
                    System.out.println("program ended");
                    System.exit(0);
                    break; 
            }
        }
    }
}