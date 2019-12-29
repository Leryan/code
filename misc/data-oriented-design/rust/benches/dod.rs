#[macro_use]
extern crate criterion;
use lib::lib::{Ctrl, Value};

use criterion::{BenchmarkId, Criterion};

fn bench_ctrl(c: &mut Criterion) {
    let elements = 100000;
    let mut ctrl_i64 = Ctrl::new();
    let mut ctrl_string = Ctrl::new();
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

    let mut group = c.benchmark_group("ctrl");
    for i in [1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::new("slow i64", i), &i, |b, i| {
            b.iter(|| ctrl_i64.get_slow(**i))
        });

        group.bench_with_input(BenchmarkId::new("fast i64", i), &i, |b, i| {
            b.iter(|| ctrl_i64.get_fast(**i))
        });

        group.bench_with_input(BenchmarkId::new("slow string", i), &i, |b, i| {
            b.iter(|| ctrl_string.get_slow(**i))
        });

        group.bench_with_input(BenchmarkId::new("fast string", i), &i, |b, i| {
            b.iter(|| ctrl_string.get_fast(**i))
        });
    }
}

criterion_group!(benches, bench_ctrl);
criterion_main!(benches);
