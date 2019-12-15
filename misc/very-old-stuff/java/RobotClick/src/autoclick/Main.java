package autoclick;

import java.awt.AWTException;

public class Main
{
    /**
     * @param args
     * @throws AWTException
     * @throws InterruptedException
     */
    public static void main(String[] args) throws AWTException, InterruptedException
    {
        Autoclick ac = new Autoclick();
        ac.rotMouseAuto(ac.getDimWidth() / 2, ac.getDimHeight() / 2, 360.0 * 1, ac.getDimHeight() / 2, 0.1, 1);
        ac.sinusMove(0, ac.getDimHeight() / 2, 100, 1, 2, false);
    }
}
