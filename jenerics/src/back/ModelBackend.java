package back;

public class ModelBackend<T, M extends BaseModel<T>> extends BaseBackend<T, M> {

    @Override
    public M get(T id) {
        return (M) new Model<>(id);
    }

}
