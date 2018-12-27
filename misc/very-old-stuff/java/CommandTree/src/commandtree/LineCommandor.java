package commandtree;

import java.util.HashMap;

public class LineCommandor
{
    private CommandNode commandManager;

    public LineCommandor()
    {
        this.commandManager = new CommandNode("Master")
        {
            @Override
            protected void setNodes()
            {
                this.childs.put("coucou", new CommandNode("cmdCoucou")
                {
                    @Override
                    protected void setNodes()
                    {
                        this.childs.put("prout", new CommandNode("cmdProut")
                        {
                            @Override
                            public Object execute(String cmd)
                            {
                                if(cmd.length() > 0) affiche("*" + cmd + "* OMG COMMENT ÇA PUE !");
                                else this.execute();
                                return null;
                            }
                        });

                        this.childs.put("say", new CommandNode("cmdSay")
                        {
                            @Override
                            public Object execute(String cmd)
                            {
                                if(cmd.length() > 0) affiche("Coucou " + cmd);
                                else this.execute();
                                return null;
                            }
                        });

                        this.childs.put("beer", new CommandNode("cmdBeer")
                        {
                            @Override
                            public Object execute(String cmd)
                            {
                                if(cmd.length() > 0) affiche("/me donne une bière à " + cmd);
                                else this.execute();
                                return null;
                            }
                        });
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

        protected Object execute() {
			affiche("Missing arguments.");
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
