/**
 *
 */
package autoclick;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Dimension;
import java.awt.Toolkit;

/**
 * @author Leryan
 *
 */
public class Autoclick extends Robot
{
    private Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();

    /**
     *
     * @throws AWTException
     */
    public Autoclick() throws AWTException
    {
        super();
    }

    /**
     *
     * @return hauteur de l'écran
     */
    public int getDimHeight()
    {
        return dim.height;
    }

    /**
     *
     * @return largeut de l'écran
     */
    public int getDimWidth()
    {
        return dim.width;
    }

    /**
     *
     * @param a     : centre x
     * @param b     : centre y
     * @param arg   : angle total à parcourir
     * @param mod   : distance par rapport à (a;b)
     */
    public void rotMouse(int a, int b, double arg, double mod)
    {
        int x = a + (int) (mod * Math.cos(arg * Math.PI / 180.0));
        int y = b + (int) (mod * Math.sin(arg * Math.PI / 180.0));
        this.mouseMove(x, y);
    }

    /**
     *
     * @param a         : centre x
     * @param b         : centre y
     * @param arg       : angle total à parcourir
     * @param mod       : distance par rapport à (a;b)
     * @param argStep   : angle fait entre chaque calcul
     * @param milli     : pause avant de continuer à tourner
     * @throws InterruptedException
     */
    public void rotMouseAuto(int a, int b, double arg, double mod, double argStep, long milli) throws InterruptedException
    {
        double angle = 0.0;

        while (angle < arg)
        {
            this.rotMouse(a, b, angle, mod);
            angle += argStep;
            Thread.sleep(milli);
        }
    }

    /**
     *
     * @param a
     * @param b
     * @param amp
     * @param step
     * @param milli
     * @param cont
     * @throws InterruptedException
     */
    public void sinusMove(int a, int b, int amp, int step, long milli, boolean cont) throws InterruptedException
    {
        while (cont || a < this.getDimWidth())
        {
            if (a == this.getDimWidth() && cont)
            {
                a = 1;
            }
            this.mouseMove(a, b + (int) (Math.sin(a * Math.PI / 180.0) * (double) amp));
            a += step;
            Thread.sleep(milli);
        }
    }
}
