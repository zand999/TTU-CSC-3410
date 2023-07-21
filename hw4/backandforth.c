#include <stdio.h>
#include <string.h>
unsigned int addstr(char *a, char *b);
int is_palindrome(char *s,int i);
unsigned int is_palindromec(char s[]);
unsigned int factstr(char *s);
int fact(int n);
void palindrome_check();
void removenewline(char *s);
//if(is_palindrome(teststring)){ printf("true\n");}printf("false\n");
//printf("fact: %d", fact(4));

int main(){
    int choice;
    int returnval;
    char string1[10];
    char string2[10];
    char palindrome[100];
    int palindromeln;
    
    do{
    printf("\nFunctions:\n");
    printf("1. addstr()\n");
    printf("2. is_palindrome()\n");
    printf("3. factstr()\n");
    printf("4. palindrome_check()\n");
    printf("Choose 1-4\n");
    scanf("%d%*c", &choice);
    
    switch(choice){
        case 1: 
            printf("Enter Num1:");
            //alt: scanf("%19s",string1)
            fgets(string1 ,10,stdin);
            
            printf("Enter Num2:");
            fgets(string2,10,stdin);
            
            //printf("1:%s2:%s",string1, string2);
            returnval = addstr(string1, string2);
            printf("Result: %d", returnval);
            break;
        case 2: 
            printf("Enter String:");
            fgets(palindrome ,100,stdin);
            palindromeln = strlen(palindrome)-2;
            //printf("ln:%d\n", palindromeln);
            //char testvar[] = {'q','e','w','s','e','q'};
            //you said we could use our old code and that code
            //had two arguments the string and the length
            //int returnval = is_palindrome(testvar,3);
            //printf("returnval:%d\n", returnval);
            
            if(is_palindrome(palindrome,palindromeln)){
                printf("It is a palindrome\n");
            }else{
                printf("It is not a palindrome\n");
            }
            break;
        case 3:
            printf("Enter String:");
            fgets(string1 ,10,stdin);
            returnval = factstr(string1);
            printf("Result: %d", returnval);
            
            break;
        case 4:
            palindrome_check();

            break;
        default: 
            choice = 0; 
            break;

    }
    }while(choice > 0 && choice < 5);
}

int fact(int n){

    if(n == 0){
        return 1;
    }else if(n < 0){
        return 0;
    }
    return n * fact(n-1);

}

unsigned int is_palindromec(char s[]){

    
    //int size;
    int size = strlen(s);
    /*for(int i = 0; s[i] != '\0'; i ++){
        size = i;
        printf("size:%d", size);
    }
    */
    size -= 2;

    for(int i = 0; i < size; size--, i++){
        
        if(s[i] != s[size]){
            printf("\n");
           return 0;
       }

    }
    printf("\n");
    //printf("aaaaaaaaaaaaaaaaaaaaaaaaaaaa\n");
    return 1;

}

/*
for(int i = 0; i < size; size--, i++){
        printf("%d", i);
        if(s[i] != s[size]){
            printf("(-)");
           return 0;
       }

    }*/
