/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ircdoo;

import java.util.Scanner;

public class KeyboardListener extends Thread
{
    public KeyboardReadListener exec;

    public KeyboardListener(KeyboardReadListener exec)
    {
        this.exec = exec;
        setDaemon(true); // Pour l'arrêter si le thread principal s'arrête
    }

    @Override
    public void run()
    {
        Scanner sc = new Scanner(System.in);
        while (true)
        {
            String s = sc.nextLine();
            exec.execute(s);
        }
    }

    public interface KeyboardReadListener
    {
        public void execute(String s);
    }
}
