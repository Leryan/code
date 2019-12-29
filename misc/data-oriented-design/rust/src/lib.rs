pub mod lib {
    use std::collections::HashMap;

    #[derive(Clone)]
    pub struct Value {
        pub key: i32,
        pub data1: String,
        pub data2: String,
        pub data3: String,
        pub data4: String,
        pub data5: String,
        pub data6: String,
        pub data7: String,
        pub data8: String,
        pub data9: String,
        pub data10: String,
        pub data11: String,
        pub data12: String,
        pub data13: String,
        pub data14: String,
        pub data15: String,
        pub data16: String,
        pub data17: String,
        pub data18: String,
        pub data19: String,
    }

    impl Value {
        pub fn new(key: i32) -> Self {
            let s = String::from("anusrietnrsautienrsautienrstauinrestaunrisetanrusiteauie");
            Value {
                key: key,
                data1: s.clone(),
                data2: s.clone(),
                data3: s.clone(),
                data4: s.clone(),
                data5: s.clone(),
                data6: s.clone(),
                data7: s.clone(),
                data8: s.clone(),
                data9: s.clone(),
                data10: s.clone(),
                data11: s.clone(),
                data12: s.clone(),
                data13: s.clone(),
                data14: s.clone(),
                data15: s.clone(),
                data16: s.clone(),
                data17: s.clone(),
                data18: s.clone(),
                data19: s.clone(),
            }
        }
    }

    pub struct Ctrl {
        slow: HashMap<i32, Value>,
        fast_idx: Vec<Value>,
        fast_map: HashMap<i32, usize>,
    }

    impl Ctrl {
        pub fn new() -> Self {
            Ctrl {
                slow: HashMap::new(),
                fast_idx: Vec::new(),
                fast_map: HashMap::new(),
            }
        }

        pub fn generate(&mut self, elements: i32) {
            for i in 0..elements {
                let v = Value::new(i);
                self.fast_idx.push(v.clone());
                self.fast_map.insert(i, self.fast_idx.len() - 1);
                self.slow.insert(i, v);
            }
        }

        pub fn get_slow(&self, key: i32) -> Value {
            return self.slow.get(&key).unwrap().clone();
        }

        pub fn get_fast(&self, key: i32) -> Value {
            let i = *self.fast_map.get(&key).unwrap();
            return self.fast_idx.get(i).unwrap().clone();
        }
    }
}
