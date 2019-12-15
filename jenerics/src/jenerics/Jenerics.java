package jenerics;

public class Jenerics {

    public static void main(String[] args) {
        var concreteBack2 = new ModelBackend<String>("elsewhere");
        var m2 = concreteBack2.get("prout2");
        m2.doStuff();
    }

}
