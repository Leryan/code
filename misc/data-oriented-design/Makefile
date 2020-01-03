c:
	gcc soa.c -O2 -Wall -pedantic -std=c11 -o soa.O2
	gcc soa.c -O2 -Wall -pedantic -std=c11 -o soa.O2.s -S -g -fverbose-asm
	gcc soa.c -O2 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O2-spec
	gcc soa.c -O2 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O2-spec.s -S -g -fverbose-asm
	gcc soa.c -O3 -Wall -pedantic -std=c11 -o soa.O3
	gcc soa.c -O3 -Wall -pedantic -std=c11 -o soa.O3.s -S -g -fverbose-asm
	gcc soa.c -O3 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O3-spec
	gcc soa.c -O3 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O3-spec.s -S -g -fverbose-asm
run_c:
	echo warmup
	time ./soa.O2
	echo bench
	time ./soa.O2
	time ./soa.O2-spec
	time ./soa.O3
	time ./soa.O3-spec
