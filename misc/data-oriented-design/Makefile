CC=clang

c:
	$(CC) soa.c -O2 -Wall -pedantic -std=c11 -o soa.O2
	$(CC) soa.c -O2 -Wall -pedantic -std=c11 -o soa.O2.s -S -g -fverbose-asm
	$(CC) soa.c -O2 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O2-spec
	$(CC) soa.c -O2 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O2-spec.s -S -g -fverbose-asm
	$(CC) soa.c -O3 -Wall -pedantic -std=c11 -o soa.O3
	$(CC) soa.c -O3 -Wall -pedantic -std=c11 -o soa.O3.s -S -g -fverbose-asm
	$(CC) soa.c -O3 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O3-spec
	$(CC) soa.c -O3 -Wall -pedantic -std=c11 -mtune=native -march=native -o soa.O3-spec.s -S -g -fverbose-asm

run_c:
	echo warmup
	time ./soa.O2
	echo bench
	time ./soa.O2
	time ./soa.O2-spec
	time ./soa.O3
	time ./soa.O3-spec
