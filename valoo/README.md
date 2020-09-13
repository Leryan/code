# Indexation

## MPP - 16/08/2018

```python
next_update = models.DateTimeField(_("Date de prochaine mise à jour"), null=True, db_index=True)
```

Ce champs devrait plutôt avoir une `next_date` à la valeur zéro par défaut afin d’éviter un filtrage supplémentaire sur None.

 * `broker/tasks.py#get_anonanon_to_be_updated`

**Réponse :**

# Django / ORM / SQL

## Slice / Batch

Ne pas utiliser un batch manuel sur un `SELECT` (`LIMIT` + `OFFSET`), mais laisser faire les pilotes de BDD qui utilisent des `curseurs`, et utiliser le `slicing` python ou simplement itérer :

```python
queryset = LeModel.objects.all() # plusieurs millions d'enregistrements… centaines de millions, peu importe
small_set = []
for doc in queryset:
    small_set.append(doc)
    
    if len(small_set) >= batch_size:
        do_something_with_that_batch(small_set)
        small_set = []
do_something_with_that_batch(small_set)
```

Raison : faire un batch à la main avec un limit/offset (`LeModel.objects.all()[start:end]`) va potentiellement faire exécuter la requête pour chaque tranche. Lorsque la requête est simple, que les index sont bien placés et qu’il n’y a pas ou peu de calculs, la différence ne se fera pas sentir. Mais pour des requêtes déjà pas optimisées à la base, ou qu’il manque des index, ou que (et vous ne pourrez rien y faire) la requête nécessite de calculer des valeurs à la volée, l’impact sera flagrand, notemment sur des volumes de données importants.

# PostgreSQL

## Stats

 * http://www.craigkerstiens.com/2012/10/01/understanding-postgres-performance/

### Ratio cache hit


```sql
SELECT 
  sum(heap_blks_read) as heap_read,
  sum(heap_blks_hit)  as heap_hit,
  sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) as ratio
FROM 
  pg_statio_user_tables;
```

### Index use

```sql
SELECT
  relname,
  100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used,
  n_live_tup rows_in_table
FROM
  pg_stat_user_tables
WHERE
    seq_scan + idx_scan > 0
ORDER BY
  n_live_tup DESC;
```

## Explain

```sql
explain (analyze, costs, verbose, buffers) <query>;
```

## HigherThan500

Pour cette requête correspondant au `HigherThan500` :

```sql
SELECT "anonanon_anonanon"."id", ('30 days 36000.000000 seconds'::interval + '2018-08-22T09:01:46.416900+00:00'::timestamptz) AS "next_update_candidate" FROM "anonanon_anonanon" LEFT OUTER JOIN "anonanon_temporaryannotatedanonanon" ON ("anonanon_anonanon"."id" = "anonanon_temporaryannotatedanonanon"."anonanon_id") WHERE ((SELECT (CASE WHEN U0."country_id" = 'FR' THEN 1.0 WHEN U0."country_id" = 'IT' THEN 1.0 WHEN U0."country_id" = 'ES' THEN 1.0 WHEN U0."country_id" = 'DE' THEN 1.0 WHEN U0."country_id" = 'AD' THEN 1.0 WHEN U0."country_id" = 'BE' THEN 1.0 WHEN U0."country_id" = 'LU' THEN 1.0 WHEN U0."country_id" = 'US' THEN 1.0 WHEN U0."country_id" = 'CA' THEN 0.628487319011364 WHEN U0."country_id" = 'MX'
THEN 1.0 WHEN U0."country_id" = 'GB' THEN 1.0 WHEN U0."country_id" = 'CH' THEN 0.847 ELSE NULL END * U0."value") AS "value_euro" FROM "estimation_estimation" U0 WHERE U0."anonanon_id" = ("anonanon_anonanon"."id") ORDER BY CASE WHEN U0."country_id" = 'FR' THEN 0 WHEN U0."country_id" = 'CH' THEN 1 WHEN U0."country_id" = 'DE' THEN 2 WHEN U0."country_id" = 'CA' THEN 3 WHEN U0."country_id" = 'LU' THEN 4 ELSE NULL END ASC, U0."date" DESC LIMIT 1) >= 500 AND "anonanon_temporaryannotatedanonanon"."id" IS NULL) ORDER BY "anonanon_anonanon"."id" ASC LIMIT 1000 OFFSET 1000; args=(datetime.timedelta(30, 36000), datetime.datetime(2018, 8, 22, 9, 1, 46, 416900, tzinfo=<UTC>), 'FR', 1.0, 'IT', 1.0, 'ES', 1.0, 'DE', 1.0, 'AD', 1.0, 'BE', 1.0, 'LU', 1.0, 'US', 1.0, 'CA', 0.628487319011364, 'MX', 1.0, 'GB', 1.0, 'CH', 0.847, 'FR', 0, 'CH', 1, 'DE', 2, 'CA', 3, 'LU', 4, 500)
```

```
 Limit  (cost=6294550399.54..6294550399.54 rows=1 width=4) (actual time=57468.151..57468.280 rows=1000 loops=1)                                                                       [18/1801]
   Output: anonanon_anonanon.id, (('2018-08-22 09:01:46.4169+00'::timestamp with time zone + '30 days 10:00:00'::interval))
   Buffers: shared hit=21953038 read=2505610 written=14
   ->  Sort  (cost=6294550399.53..6294550399.54 rows=1 width=4) (actual time=57468.031..57468.186 rows=2000 loops=1)
         Output: anonanon_anonanon.id, (('2018-08-22 09:01:46.4169+00'::timestamp with time zone + '30 days 10:00:00'::interval))
         Sort Key: anonanon_anonanon.id
         Sort Method: top-N heapsort  Memory: 190kB
         Buffers: shared hit=21953038 read=2505610 written=14
         ->  Nested Loop Left Join  (cost=0.29..6294550399.52 rows=1 width=4) (actual time=1.044..57442.831 rows=134067 loops=1)
               Output: anonanon_anonanon.id, ('2018-08-22 09:01:46.4169+00'::timestamp with time zone + '30 days 10:00:00'::interval)
               Filter: (anonanon_temporaryannotatedanonanon.id IS NULL)
               Rows Removed by Filter: 21810
               Buffers: shared hit=21953038 read=2505610 written=14
               ->  Seq Scan on public.anonanon_anonanon  (cost=0.00..6294145611.76 rows=1267615 width=4) (actual time=1.036..57119.137 rows=155876 loops=1)
                     Output: anonanon_anonanon.id, anonanon_anonanon.date_created, anonanon_anonanon.date_updated, anonanon_anonanon.manufacturer, anonanon_anonanon.brand, anonanon_anonanon.model, produ$
t_anonanon.category_id, anonanon_anonanon.property_count, anonanon_anonanon.done_updates, anonanon_anonanon.hidden, anonanon_anonanon.date_updated_es
                     Filter: ((SubPlan 1) >= 500::double precision)
                     Rows Removed by Filter: 3646970
                     Buffers: shared hit=21623514 read=2501410 written=14
                     SubPlan 1
                       ->  Limit  (cost=1655.08..1655.09 rows=1 width=15) (actual time=0.015..0.015 rows=1 loops=3802846)
                             Output: (((CASE WHEN ((u0.country_id)::text = 'FR'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'IT'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'ES'::text) TH
EN 1.0 WHEN ((u0.country_id)::text = 'DE'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'AD'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'BE'::text) THEN 1.0 WHEN ((u0.country_id)::text = '
LU'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'US'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CA'::text) THEN 0.628487319011364 WHEN ((u0.country_id)::text = 'MX'::text) THEN 1.0 WHEN
 ((u0.country_id)::text = 'GB'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 0.847 ELSE NULL::numeric END)::double precision * u0.value)), (CASE WHEN ((u0.country_id)::text =
 'FR'::text) THEN 0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 1 WHEN ((u0.country_id)::text = 'DE'::text) THEN 2 WHEN ((u0.country_id)::text = 'CA'::text) THEN 3 WHEN ((u0.country_id)::t
ext = 'LU'::text) THEN 4 ELSE NULL::integer END), u0.date
                             Buffers: shared hit=21623500 read=2444004 written=14
                             ->  Sort  (cost=1655.08..1656.13 rows=418 width=15) (actual time=0.014..0.014 rows=1 loops=3802846)
                                   Output: (((CASE WHEN ((u0.country_id)::text = 'FR'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'IT'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'ES'::te
xt) THEN 1.0 WHEN ((u0.country_id)::text = 'DE'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'AD'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'BE'::text) THEN 1.0 WHEN ((u0.country_id)::te
xt = 'LU'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'US'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CA'::text) THEN 0.628487319011364 WHEN ((u0.country_id)::text = 'MX'::text) THEN 1.
0 WHEN ((u0.country_id)::text = 'GB'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 0.847 ELSE NULL::numeric END)::double precision * u0.value)), (CASE WHEN ((u0.country_id)::
text = 'FR'::text) THEN 0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 1 WHEN ((u0.country_id)::text = 'DE'::text) THEN 2 WHEN ((u0.country_id)::text = 'CA'::text) THEN 3 WHEN ((u0.country_
id)::text = 'LU'::text) THEN 4 ELSE NULL::integer END), u0.date
                                   Sort Key: (CASE WHEN ((u0.country_id)::text = 'FR'::text) THEN 0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 1 WHEN ((u0.country_id)::text = 'DE'::text)
THEN 2 WHEN ((u0.country_id)::text = 'CA'::text) THEN 3 WHEN ((u0.country_id)::text = 'LU'::text) THEN 4 ELSE NULL::integer END), u0.date
                                   Sort Method: quicksort  Memory: 25kB
                                   Buffers: shared hit=21623500 read=2444004 written=14
                                   ->  Bitmap Heap Scan on public.estimation_estimation u0  (cost=11.80..1652.99 rows=418 width=15) (actual time=0.004..0.012 rows=9 loops=3802846)
                                         Output: ((CASE WHEN ((u0.country_id)::text = 'FR'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'IT'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'ES
'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'DE'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'AD'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'BE'::text) THEN 1.0 WHEN ((u0.country_id
)::text = 'LU'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'US'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CA'::text) THEN 0.628487319011364 WHEN ((u0.country_id)::text = 'MX'::text) TH
EN 1.0 WHEN ((u0.country_id)::text = 'GB'::text) THEN 1.0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 0.847 ELSE NULL::numeric END)::double precision * u0.value), CASE WHEN ((u0.country_id
)::text = 'FR'::text) THEN 0 WHEN ((u0.country_id)::text = 'CH'::text) THEN 1 WHEN ((u0.country_id)::text = 'DE'::text) THEN 2 WHEN ((u0.country_id)::text = 'CA'::text) THEN 3 WHEN ((u0.count
ry_id)::text = 'LU'::text) THEN 4 ELSE NULL::integer END, u0.date
                                         Recheck Cond: (u0.anonanon_id = anonanon_anonanon.id)
                                         Heap Blocks: exact=8755573
                                         Buffers: shared hit=21623500 read=2444004 written=14
                                         ->  Bitmap Index Scan on estimation_estimation_9bea82de  (cost=0.00..11.70 rows=418 width=0) (actual time=0.002..0.002 rows=9 loops=3802846)
                                               Index Cond: (u0.anonanon_id = anonanon_anonanon.id)
                                               Buffers: shared hit=15010466 read=301465 written=1
               ->  Index Scan using anonanon_temporaryannotatedanonanon_anonanon_id_16e8b797 on public.anonanon_temporaryannotatedanonanon  (cost=0.29..0.31 rows=1 width=8) (actual time=0.001..0.0
01 rows=0 loops=155876)
                     Output: anonanon_temporaryannotatedanonanon.id, anonanon_temporaryannotatedanonanon.next_update_candidate, anonanon_temporaryannotatedanonanon.anonanon_id
                     Index Cond: (anonanon_anonanon.id = anonanon_temporaryannotatedanonanon.anonanon_id)
                     Buffers: shared hit=329524 read=4200
 Planning time: 0.326 ms
 Execution time: 57468.349 ms
```
