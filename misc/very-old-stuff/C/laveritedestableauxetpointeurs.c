#include <stdio.h>
#include <stdlib.h>

void affiche_liste_ptr(const char **liste)
{
    int i;

    for(i = 0; **liste != '\n'; i++, liste++)
    {
        printf("%d. %s\n", i + 1, *liste);
    }
}

void affiche_liste_tab(const char *liste[])
{
    int i;

    for(i = 0; liste[i][0] != '\n'; i++)
    {
        printf("%d. %s\n", i + 1, liste[i]);
    }
}

int main(void)
{
    const char *couleurs[] = {"couleur1", "couleur2", "\n"};

    //couleurs[0][2] = 'z'; //Même sans const ça fera planter le prog
    //car on fait un tableau de chaînes constantes.
    //Donc on se retrouvera quand même avec du const char sur chaque *(couleurs[i] + n)

    puts("affiche_liste_ptr(couleurs)");
    affiche_liste_ptr(couleurs);
    puts("affiche_liste_tab(couleurs)");
    affiche_liste_tab(couleurs);
    return 0;
}
