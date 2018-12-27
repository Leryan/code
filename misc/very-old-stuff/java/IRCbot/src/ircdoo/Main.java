/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ircdoo;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
/**
 *
 * @author leryan
 */
public class Main
{
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws UnknownHostException, IOException, InterruptedException
    {
        /* */
        String[] servers =
        {
        "irc.epiknet.org", "chat.freenode.net"
        };
        IrcLogin ircLogs = new IrcLogin("test_java", "Florent", "test_java", "", "chewy", "localhost");
        new IrcDooBiDoo(InetAddress.getByName(servers[0]), 6667, ircLogs).dooBi.exec();
        /* */
    }
}
