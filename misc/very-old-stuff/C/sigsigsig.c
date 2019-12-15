#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <ucontext.h>

pid_t r_fork;

void handler(int signal, int code, struct sigcontext *scp, char *addr) {
	printf("Signal %d\n", signal);
	fflush(stdout);
}

int main(void) {
	struct sigaction action;
	r_fork  = fork();
	if(r_fork == 0) {
		action.sa_handler = &handler;
		action.sa_flags = SA_SIGINFO;

		sigemptyset(&action.sa_mask);

		sigaction(SIGINT, &action, 0);
		sigaction(SIGQUIT, &action, 0);
		sigaction(SIGTERM, &action, 0);
		while(1) {
			printf("Fils : PID : %d | PPID : %d\n", getpid(), getppid());
			if(getppid() == 1) {
				printf("I'M ALONE ! I really dont want to live in this world anymore.");
				fflush(stdout);
				raise(9);
			}
			sleep(5);
		}
	} else if (r_fork != -1){
		while(1) {
			printf("Père : CPID : %d | PID : %d | PPID : %d\n", r_fork, getpid(), getppid());
			sleep(5);
		}
	}
	return EXIT_SUCCESS;
}

