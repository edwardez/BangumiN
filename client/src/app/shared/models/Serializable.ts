export interface Serializable<T> {
    deserialize(input: Object): T;
}
