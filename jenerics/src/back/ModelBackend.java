package back;

public class ModelBackend<T> extends BaseBackend<T, Model<T>> {

    @Override
    public Model<T> get(T id) {
        return new Model<>(id);
    }

}
