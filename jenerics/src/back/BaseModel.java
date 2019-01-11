package back;

public class BaseModel<T> {

    private T id;

    public BaseModel(T id) {
        this.id = id;
    }

    public final T ID() {
        return this.id;
    }
}
