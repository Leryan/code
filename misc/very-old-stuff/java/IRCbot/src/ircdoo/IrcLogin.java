/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ircdoo;

import javax.swing.JTextField;

/**
 *
 * @author leryan
 */
public class IrcLogin
{
    public String nick, realname, username, password, hostname, servername;

    public String getHostname()
    {
        return hostname;
    }

    public String getNick()
    {
        return nick;
    }

    public String getPassword()
    {
        return password;
    }

    public String getRealname()
    {
        return realname;
    }

    public String getServername()
    {
        return servername;
    }

    public String getUsername()
    {
        return username;
    }

    public IrcLogin(String nick, String realname, String username, String password, String hostname, String servername)
    {
        this.nick = nick;
        this.realname = realname;
        this.username = username;
        this.password = password;
        this.hostname = hostname;
        this.servername = servername;
    }
}
