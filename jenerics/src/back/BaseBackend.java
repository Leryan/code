package back;

public abstract class BaseBackend<T, M> {

    private String connection;

    public BaseBackend(String connection) {
        this.connection = connection;
    }

    public abstract M get(T id);

}
