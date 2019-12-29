pub mod lib {
    use std::collections::HashMap;

    pub trait Data<T> {
        fn data(&self) -> T;
        fn key(&self) -> i32;
    }

    #[derive(Clone)]
    pub struct Value<T> {
        pub key: i32,
        pub data1: T,
        pub data2: T,
        pub data3: T,
        pub data4: T,
        pub data5: T,
        pub data6: T,
        pub data7: T,
        pub data8: T,
        pub data9: T,
        pub data10: T,
    }

    impl<T: Clone> Data<T> for Value<T> {
        fn data(&self) -> T {
            self.data6.clone()
        }
        fn key(&self) -> i32 {
            self.key
        }
    }

    pub struct Ctrl<V> {
        slow: HashMap<i32, Value<V>>,
        slow_fast: HashMap<i32, V>,
        fast_idx: Vec<V>,
        fast_full_idx: Vec<Value<V>>,
        fast_map: HashMap<i32, usize>,
    }

    impl<V: Clone> Ctrl<V> {
        pub fn new() -> Self {
            Ctrl {
                slow: HashMap::new(),
                fast_idx: Vec::new(),
                fast_map: HashMap::new(),
                fast_full_idx: Vec::new(),
                slow_fast: HashMap::new(),
            }
        }

        pub fn absorbe(&mut self, element: Value<V>) {
            self.fast_idx.push(element.data().clone());
            self.fast_map.insert(element.key(), self.fast_idx.len() - 1);
            self.fast_full_idx.push(element.clone());
            // HashMap returns a reference and not a copy of a value, so demonstrating with dicts
            // doesn't really show anything regarding DoD.
            // Except that strings are slow af.
            self.slow.insert(element.key(), element.clone());
            self.slow_fast.insert(element.key(), element.data().clone());
        }

        pub fn get_slow(&self, key: i32) -> Value<V> {
            return self.slow.get(&key).unwrap().clone();
        }

        pub fn get_slow_fast(&self, key: i32) -> V {
            return self.slow_fast.get(&key).unwrap().clone();
        }

        pub fn get_fast(&self, key: i32) -> V {
            let i = *self.fast_map.get(&key).unwrap();
            return self.fast_idx.get(i).unwrap().clone();
        }

        pub fn get_fast_full(&self, key: i32) -> Value<V> {
            let i = *self.fast_map.get(&key).unwrap();
            return self.fast_full_idx.get(i).unwrap().clone();
        }
    }
}
