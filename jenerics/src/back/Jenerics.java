package back;

public class Jenerics {

    public static void main(String[] args) {
        var baseBack = new ModelBackend();
        var wm = baseBack.get("pwet");
        // cannot call wm.doStuff()
        System.out.println("no concrete type: " + wm.ID());

        var concreteBack = new ModelBackend<String, Model<String>>();
        var m = concreteBack.get("prout");
        m.doStuff();
        System.out.println("concrete type: " + m.ID());
    }

}
