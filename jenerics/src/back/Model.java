package back;

public class Model<T> extends BaseModel<T> {

    public T id;

    public Model(T id) {
        this.id = id;
    }

    public void doStuff() {
        System.out.println("i do stuff: " + this.id);
    }

    public T ID() {
        return this.id;
    }

}
