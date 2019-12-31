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
        name: String,
    }

    impl<V: Clone> Ctrl<V> {
        pub fn new(name: &str) -> Self {
            Ctrl {
                slow: HashMap::new(),
                fast_idx: Vec::new(),
                fast_map: HashMap::new(),
                fast_full_idx: Vec::new(),
                slow_fast: HashMap::new(),
                name: name.to_string(),
            }
        }

        pub fn name(&self) -> &str {
            &self.name.as_str()
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

        pub fn direct_map_value(&self, key: i32) -> Value<V> {
            self.slow.get(&key).unwrap().clone()
        }

        pub fn direct_map_value_ref(&self, key: i32) -> &Value<V> {
            self.slow.get(&key).unwrap()
        }

        pub fn direct_map_value_field(&self, key: i32) -> V {
            self.slow_fast.get(&key).unwrap().clone()
        }

        pub fn indirect_value_field(&self, key: i32) -> V {
            let i = *self.fast_map.get(&key).unwrap();
            self.fast_idx.get(i).unwrap().clone()
        }

        pub fn indirect_value(&self, key: i32) -> Value<V> {
            let i = *self.fast_map.get(&key).unwrap();
            self.fast_full_idx.get(i).unwrap().clone()
        }

        pub fn indirect_value_ref(&self, key: i32) -> &Value<V> {
            let i = *self.fast_map.get(&key).unwrap();
            self.fast_full_idx.get(i).unwrap()
        }
    }

    pub struct SOA {
        pub x: Vec<i64>,
        pub y: Vec<i64>,
        pub z: Vec<i64>,
    }

    impl SOA {
        pub fn new() -> Self {
            SOA {
                x: vec![],
                y: vec![],
                z: vec![],
            }
        }
    }

    #[derive(Debug, Clone, Copy)]
    pub struct Vec3d {
        pub x: i64,
        pub y: i64,
        pub z: i64,
    }

    pub struct SOAoAOSCtrl {
        soa: SOA,
        aos: Vec<Vec3d>,
    }

    impl SOAoAOSCtrl {
        pub fn new() -> Self {
            SOAoAOSCtrl {
                soa: SOA::new(),
                aos: vec![],
            }
        }
        pub fn add(&mut self, vec3d: Vec3d) {
            self.soa.x.push(vec3d.x);
            self.soa.y.push(vec3d.y);
            self.soa.z.push(vec3d.z);

            self.aos.push(vec3d);
        }

        pub fn soa_translate(&mut self, vec3d: Vec3d) {
            for v in self.soa.x.iter_mut() {
                *v += vec3d.x;
            }
            for v in self.soa.y.iter_mut() {
                *v += vec3d.y;
            }
            for v in self.soa.z.iter_mut() {
                *v += vec3d.z;
            }
        }

        pub fn aos_translate(&mut self, vec3d: Vec3d) {
            for v in self.aos.iter_mut() {
                v.x += vec3d.x;
                v.y += vec3d.y;
                v.z += vec3d.z;
            }
        }
    }
}
