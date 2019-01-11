package back;

public class BaseModel<T> implements IBaseModel<T> {

    private T id;

    public BaseModel(T id) {
        this.id = id;
    }

    @Override
    public T ID() {
        return this.id;
    }
}
