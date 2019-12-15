package jenerics;

public class Model<T> extends BaseModel<T> {

    public String someData;

    public Model(T id) {
        super(id);
    }

    public void doStuff() {
        System.out.println("i do stuff: " + this.ID() + ", data: " + this.someData);
    }

}
