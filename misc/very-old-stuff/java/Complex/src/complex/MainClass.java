package Complex;

public class MainClass
{

    /**
     * @param args
     */
    public static void main(String[] args)
    {
        short sizeme = 10;
        boolean tab[][] = new boolean[sizeme][sizeme];
        int i, j;
        Complex pos = new Complex(1.0, 1.0);
        Complex truc = new Complex(3.0, 4.5);

        for(i = 0 ; i < sizeme ; i++)
        {
            for(j = 0 ; j < sizeme ; j++)
            {
                tab[i][j] = false;
            }
        }

        System.out.println(pos.toString());
        pos.rot(90.0);
        System.out.println(pos.toString());
        pos.mul(truc);
        System.out.println(pos.toString());
        pos.conj();
        System.out.println(pos.toString());
        pos.mulconj();
        System.out.println(pos.toString());
    }
}
