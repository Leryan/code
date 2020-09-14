package Complex;

public class Complex
{
    private double reel, img;
    private double getArgTan()
    {
        return Math.atan(this.img/this.reel);
    }

    public Complex()
    {
        this.setComplex(0.0, 0.0);
    }

    public Complex(double x, double y)
    {
        this.setComplex(x, y);
    }

    public void setComplex(double x, double y)
    {
        this.setReel(x);
        this.setImg(y);
    }
    public void setReel(double x){ this.reel = x; }
    public void setImg(double y) { this.img = y; }
    public double getReel() { return this.reel; }
    public double getImg(){ return this.img; }
    public double getArg()
    {
        if(this.reel < 0.0)
        {
            if(this.img > 0.0) return getArgTan() + Math.PI;
            else return getArgTan() - Math.PI;
        }
        else return getArgTan();
    }
    public double getArgD(){ return getArg() * 180.0/ Math.PI; }
    public double getMod(){ return Math.sqrt(this.reel * this.reel + this.img * this.img); }

    public void rot(double R)
    {
        double nReel, nArg;
        nArg = this.getArg() + (R * Math.PI) / 360.0;
        nReel = this.getMod() * Math.cos(nArg);
        this.img = this.getMod() * Math.sin(nArg);
        this.reel = nReel;
    }

    public void mul(Complex z)
    {
        double tmp;
        tmp = this.reel * z.reel -(this.img * z.img);
        this.img = this.reel * z.img + this.img * z.reel;
        this.reel = tmp;
    }

    public void add(Complex z)
    {
        this.reel += z.reel;
        this.img += z.img;
    }

    public void sous(Complex z)
    {
        this.reel -= z.reel;
        this.img -= z.img;
    }

    public void div(Complex z)
    {
        double tmp;
        tmp = (this.reel * z.reel -(this.img * z.img)) / (this.reel * this.reel + this.img * this.img);
        this.img = (this.reel * z.img + this.img * z.reel) / (this.reel * this.reel + this.img * this.img);
        this.reel = tmp;
    }

    public void conj()
    {
        this.img *= -1.0;
    }

    public void mulconj()
    {
        this.reel = this.reel * this.reel + this.img * this.img;
        this.img = 0.0;
    }

    @Override
    public String toString()
    {
        return "z = " + this.reel + " + " + this.img + "i\t" + "|z| = " + this.getMod() + "\tArg(z) = " + this.getArgD();
    }
}
