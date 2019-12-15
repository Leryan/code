/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaserver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

/**
 *
 * @author leryan
 */
public class Main
{
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException
    {
        Scanner sc = new Scanner(System.in);
        System.out.print("Set local listening port: ");
        final int port = Integer.valueOf(sc.nextLine());
        final ServerSocket srvsok = new ServerSocket(port);
        Thread serverd = new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                try
                {
                    System.out.println("Server is running on " + InetAddress.getLocalHost().getHostAddress() + ":" + port);
                }
                catch (UnknownHostException ex){}
                while (!srvsok.isClosed())
                {
                    try
                    {
                        final Socket tSrvsok = srvsok.accept();
                        new Thread(new Runnable()
                        {
                            PrintWriter out = new PrintWriter(new OutputStreamWriter(tSrvsok.getOutputStream()));
                            IDoWhatYouWant wyw = new IDoWhatYouWant(out);
                            @Override
                            public void run()
                            {
                                System.out.println("Socket: " + tSrvsok.toString() + " opened with Thread: " + this.toString());
                                try
                                {
                                    BufferedReader in = new BufferedReader(new InputStreamReader(tSrvsok.getInputStream()));
                                    String s;
                                    while (!(s = in.readLine()).equals("/quit"))
                                    {
                                        if(s.charAt(0) == '/') wyw.execCmd(s.substring(1));
                                        else
                                        {
                                            out.println("Server: not a command.");
                                            out.flush();
                                        }
                                    }
                                    out.println("Server: Good Bye!");
                                    out.flush();
                                    tSrvsok.close();
                                    System.out.println("Socket: " + tSrvsok.toString() + " finished with Thread: " + this.toString());
                                }
                                catch (IOException ex)
                                {}
                            }
                        }).start();
                    }
                    catch (IOException ex)
                    {}
                }
            }
        });
        /* *
        KeyboardListener keyboardListener = new KeyboardListener(new KeyboardListener.KeyboardReadListener()
        {
            @Override
            public void execute(String s)
            {
                for(int i = 0; i < clisok.length; i++)
                {
                    try
                    {
                        new PrintWriter(new OutputStreamWriter(clisok[i].getOutputStream()), true).println(s);
                        System.out.println(new BufferedReader(new InputStreamReader(clisok[i].getInputStream())).readLine());
                    }
                    catch (IOException ex)
                    {
                        Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        });
        keyboardListener.start();
        /* */
        serverd.start();
    }
}
