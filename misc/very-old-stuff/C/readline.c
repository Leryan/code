#include <stdio.h>
#include <stdlib.h>

char *lji_file_readline(FILE *file)
{
    char *line = NULL;
    char c;
    int i;

    for(i = 0; c = fgetc(file), c != '\n' && c != EOF; i++);
    // ++i car le curseur de fichier est un caractère en avant.
    //En même temps ça calcul le \n
    fseek(file, -(++i), SEEK_CUR);

    //i caractères et un \0 placé par fgets
    line = malloc(sizeof(char) * (++i));
    fgets(line, i, file);

    if(c != EOF)
    {
        return line;
    }
    else
    {
        return NULL;
    }
}

int main(void)
{
    char *str = NULL;
    FILE *file = fopen("readline.c", "r");
    while((str = lji_file_readline(file)))
    {
        printf("%s", str);
        free(str);
    }
    return 0;
}
//azezae

