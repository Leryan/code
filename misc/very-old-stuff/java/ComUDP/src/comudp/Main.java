/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package comudp;

import java.net.SocketException;
import java.net.UnknownHostException;

/**
 *
 * @author leryan
 */
public class Main {
    public static void main(String[] args) throws UnknownHostException, SocketException
    {
        ComUDP com = new ComUDP("192.168.0.2:4444");
        while(true)
        {
            Thread t = com.Recevoir(0000);
            while(t.isAlive());
            System.out.println("New Thread : " + t.toString() + " answered : " + com.messageRecu);
        }
    }
}
