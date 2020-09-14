/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ircdoo;

import java.io.IOException;
import java.net.InetAddress;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author leryan
 */
public class IrcDooBiDoo extends IrcDoo
{
    public KeyboardListener keyboardListener;

    public IrcDooBiDoo(InetAddress address, int port, IrcLogin ircLogs) throws IOException
    {
        super(address, port, ircLogs);
        this.keyboardListener = new KeyboardListener(new KeyboardListener.KeyboardReadListener()
        {
            @Override
            public void execute(String s)
            {
                try
                {
                    sendCmd(s, false);
                }
                catch (IOException ex)
                {
                    Logger.getLogger(IrcDoo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });

        this.dooBi = new DooBi()
        {
            @Override
            public void exec() throws IOException
            {
                login(false);
                keyboardListener.start();

                while (getIrcSocket().isConnected())
                {
                    String ircMsg = getLine();
                    getPingThenPong(ircMsg);
                    if (ircMsg.split(":").length > 2)
                    {
                        System.out.println(ircMsg.substring(ircMsg.indexOf(ircMsg.split(":")[2])));
                    }
                    else System.out.println(ircMsg);
                }
            }
        };
    }
}
