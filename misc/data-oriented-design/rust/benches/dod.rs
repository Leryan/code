#[macro_use]
extern crate criterion;
use lib::lib::{Ctrl, Value};

use criterion::{BenchmarkId, Criterion};

fn bench_ctrl(c: &mut Criterion) {
    let elements = 100000;
    let mut ctrl_i64 = Ctrl::new("i64");
    let mut ctrl_string = Ctrl::new("String");
    for key in 0..elements {
        let vi64: Value<i64> = Value {
            key: key,
            data1: (key as i64 * 10) + 1,
            data2: (key as i64 * 10) + 2,
            data3: (key as i64 * 10) + 3,
            data4: (key as i64 * 10) + 4,
            data5: (key as i64 * 10) + 5,
            data6: (key as i64 * 10) + 6,
            data7: (key as i64 * 10) + 7,
            data8: (key as i64 * 10) + 8,
            data9: (key as i64 * 10) + 9,
            data10: (key as i64 * 10) + 10,
        };
        ctrl_i64.absorbe(vi64);
        let vs: Value<String> = Value {
            key: key,
            data1: "anursietnarustie nrsauti enrsauti e".to_string(),
            data2: "anursietnarustie nrsauti enrsauti e".to_string(),
            data3: "anursietnarustie nrsauti enrsauti e".to_string(),
            data4: "anursietnarustie nrsauti enrsauti e".to_string(),
            data5: "anursietnarustie nrsauti enrsauti e".to_string(),
            data6: "anursietnarustie nrsauti enrsauti e".to_string(),
            data7: "anursietnarustie nrsauti enrsauti e".to_string(),
            data8: "anursietnarustie nrsauti enrsauti e".to_string(),
            data9: "anursietnarustie nrsauti enrsauti e".to_string(),
            data10: "anursietnarustie nrsauti enrsauti e".to_string(),
        };
        ctrl_string.absorbe(vs);
    }

    let mut group = c.benchmark_group("dod");
    let ctrl = ctrl_i64;
    for i in [1000].iter() {
        let id = format!("ctrl: {:?}: direct map -> Value<T>", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.direct_map_value(**i))
        });

        let id = format!("ctrl: {:?}: direct map -> T", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.direct_map_value_field(**i))
        });

        let id = format!("ctrl: {:?}: map -> idx -> vec[idx] -> T", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.indirect_value_field(**i))
        });

        let id = format!(
            "ctrl: {:?}: map -> idx -> vec[idx] -> Value<T>",
            ctrl.name()
        );
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.indirect_value(**i))
        });
    }

    let ctrl = ctrl_string;
    for i in [1000].iter() {
        let id = format!("ctrl: {:?}: direct map -> Value<T>", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.direct_map_value(**i))
        });

        let id = format!("ctrl: {:?}: direct map -> T", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.direct_map_value_field(**i))
        });

        let id = format!("ctrl: {:?}: map -> idx -> vec[idx] -> T", ctrl.name());
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.indirect_value_field(**i))
        });

        let id = format!(
            "ctrl: {:?}: map -> idx -> vec[idx] -> Value<T>",
            ctrl.name()
        );
        group.bench_with_input(BenchmarkId::new(id, i), &i, |b, i| {
            b.iter(|| ctrl.indirect_value(**i))
        });
    }
}

criterion_group!(benches, bench_ctrl);
criterion_main!(benches);
