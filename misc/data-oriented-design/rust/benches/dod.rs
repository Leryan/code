#[macro_use]
extern crate criterion;
use lib::lib::Ctrl;

use criterion::{BenchmarkId, Criterion};

fn bench_ctrl(c: &mut Criterion) {
    let mut group = c.benchmark_group("ctrl");

    let mut ctrl = Ctrl::new();
    ctrl.generate(100000);

    for i in [1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::new("slow", i), &i, |b, i| {
            b.iter(|| ctrl.get_slow(**i).data6)
        });

        group.bench_with_input(BenchmarkId::new("fast", i), &i, |b, i| {
            b.iter(|| ctrl.get_fast(**i).data6)
        });
    }
}

criterion_group!(benches, bench_ctrl);
criterion_main!(benches);
