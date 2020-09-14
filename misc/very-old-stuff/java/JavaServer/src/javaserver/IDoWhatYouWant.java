/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaserver;

import java.io.PrintWriter;
import java.util.HashMap;

/**
 *
 * @author leryan
 */
public class IDoWhatYouWant
{
    private CommandNode commandManager;
    private String commString = null;
    private PrintWriter out;

    public String getCommString()
    {
        return this.commString;
    }

    public IDoWhatYouWant(final PrintWriter out)
    {
        this.out = out;
        this.commandManager = new CommandNode("Master")
        {
            @Override
            protected void setNodes()
            {
                this.childs.put("say", new CommandNode("cmdSay")
                {
                    @Override
                    public Object execute(String cmd)
                    {
                        if (cmd.length() > 0)
                        {
                            out.write("Coucou " + cmd + "\n");
                            out.flush();
                        }
                        else this.execute();
                        return null;
                    }
                });
            }
        };
    }

    public final void execCmd(String cmd)
    {
        this.commandManager.execute(cmd);
    }

    private abstract class CommandNode
    {
        protected HashMap<String, CommandNode> childs;
        protected String name = "";

        private CommandNode(String name)
        {
            this.childs = new HashMap<String, CommandNode>();
            this.name = name;
            this.setNodes();
        }

        public String getName()
        {
            return this.name;
        }

        public Object execute(String commande)
        {
            String[] cmd = commande.trim().split(" ");
            if (cmd[0].length() > 0)
            {
                if (this.childs.containsKey(cmd[0].trim()))
                {
                    return this.childs.get(cmd[0]).execute(this.removeFirstWord(commande));
                }
                else return this.execute();
            }
            return null;
        }

        protected Object execute()
        {
            out.write("Missing arguments.\n");
            out.flush();
            return null;
        }

        private String removeFirstWord(String s)
        {
            return s.substring(s.split(" ")[0].length()).trim();
        }

        public void affiche(String s)
        {
            System.out.println(s);
        }

        protected void setNodes()
        {
        }
    }
}
