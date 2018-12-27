/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ircdoo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;

/**
 *
 * @author leryan
 */
public class IrcDoo
{
    private Socket ircSocket;
    private BufferedReader ircInput;
    private BufferedWriter ircOutput;
    private IrcLogin ircLogs;
    public String debugMsg;
    public boolean pinged;

    public DooBi dooBi;

    public IrcDoo(InetAddress address, int port, IrcLogin ircLogs) throws IOException
    {
        this.ircSocket = new Socket(address, port);
        this.ircInput = new BufferedReader(new InputStreamReader(this.ircSocket.getInputStream()));
        this.ircOutput = new BufferedWriter(new OutputStreamWriter(this.ircSocket.getOutputStream()));

        this.pinged = false;

        this.ircLogs = ircLogs;

        this.debugMsg = "#!DEBUG!#";
    }

    public Socket getIrcSocket()
    {
        return this.ircSocket;
    }

    public void sendCmd(String command, boolean debug) throws IOException
    {
        if (!("".equals(command)) && command != null && this.ircSocket.isConnected())
        {
            if(debug) System.out.print(this.debugMsg + command + " \n");
            this.ircOutput.write(command + " \n");
            this.ircOutput.flush();
        }
    }

    public boolean getPingThenPong(String ircMsg) throws IOException
    {
        if ("PING".equals(ircMsg.split(" ")[0]))
        {
            sendCmd("PONG " + ircMsg.split(":")[1], false);
            this.pinged = true;
            return true;
        }
        return false;
    }

    public void login(boolean debug) throws IOException
    {
        this.sendCmd("USER "
                     + ircLogs.username + " "
                     + ircLogs.hostname + " "
                     + ircLogs.servername + " "
                     + ircLogs.realname + "\n"
                     + "NICK " + ircLogs.nick, debug);
    }

    public String getLine() throws IOException
    {
        return this.ircInput.readLine();
    }

    public interface DooBi
    {
        public void exec() throws IOException;
    }
}
