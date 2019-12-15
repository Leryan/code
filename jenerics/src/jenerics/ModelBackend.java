package jenerics;

public class ModelBackend<T> extends BaseBackend<T, Model<T>> {

    public ModelBackend(String connection) {
        super(connection);
    }

    @Override
    public Model<T> get(T id) {
        Model<T> m = new Model<>(id);
        m.someData = "zugluglu";
        return m;
    }

}
