#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
void main()
{
    printf("Hello World, I'm is the first programe.\n");
    printf("+++process %d start running!ppid = %d\n",getpid(),getppid());
    pid_t pid = fork();
    if(pid)//父进程
    {
        printf("parent:process %d start running!ppid = %d\n",getpid(),getppid());
        //do something
        //...
    }
    else//子进程
    {
        printf("child:process %d start running!ppid = %d\n",getpid(),getppid());
        //do something
        //...
    }

    fflush(stdout);
    while(1);
}