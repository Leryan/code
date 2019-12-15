/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package commandtree;

/**
 *
 * @author leryan
 */
public class Main
{
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        LineCommandor cli = new LineCommandor();
        cli.execCmd("coucou say Florent");
        cli.execCmd("coucou prout MegaProut");
        cli.execCmd("coucou say ");
        cli.execCmd("coucou beer Benji");
        cli.execCmd(" ");
    }
}
