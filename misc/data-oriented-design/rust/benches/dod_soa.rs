#[macro_use]
extern crate criterion;

use criterion::Criterion;
use lib::lib::*;

fn bench_soa(c: &mut Criterion) {
    let elements: i64 = 100000;
    let mut ctrl = SOAoAOSCtrl::new();
    for i in 0..elements {
        ctrl.add(Vec3d {
            x: i,
            y: i + 1,
            z: i + 2,
        })
    }

    let translate = Vec3d { x: 4, y: -3, z: 8 };
    let mut group = c.benchmark_group("DOD SOA vs AOS");
    {
        group.bench_function("SOA copy", |b| {
            b.iter(|| ctrl.soa_translate_copy(translate))
        });
    }
    {
        group.bench_function("AOS", |b| b.iter(|| ctrl.aos_translate_inplace(translate)));
    }
    {
        group.bench_function("SOA", |b| b.iter(|| ctrl.soa_translate_inplace(translate)));
    }
}

criterion_group!(benches, bench_soa);
criterion_main!(benches);
