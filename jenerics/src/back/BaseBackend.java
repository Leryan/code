package back;

public abstract class BaseBackend<T, M extends BaseModel<T>> {

    public abstract M get(T id);
}
