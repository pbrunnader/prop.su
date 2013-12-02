/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * assigment 1
 * delegation
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 **/

#include <stdio.h>

#define FUNCTION void*

typedef struct _Function
{
    void *function;        /* function - function pointer */
    char* name;            /* name of the function */
    int argnum;            /* number of arguments */
    void* next;            /* next function */
} Function;

typedef struct _Object {
    void* proto;           /* parent object */
    Function* function;    /* first function */
    char* attribute;       /* attribute */
} Object;

void printMsg(Object* self){
    puts(self->attribute);
}

void printMsgWithDots(Object* self){
    printf("%s And I say good bye as well!",self->attribute);
}

void* invoke(void* receiver, char* functionname, int argnum, void* argvalue) {
    Object* rec = receiver;
    Object* obj = receiver;
    Function* function = obj->function;

    while(1) {
        /* if object does not have any functions assigned */
        if(function == NULL) {
            /* if not (root) last parent object then traverse to next parent object */
            if(obj->proto != NULL) {
                obj = obj->proto;
                function = obj->function;
                continue;
            } else {
                printf("ERROR: Function not found '%s'\n",functionname);
                return NULL;
            }
        } else {
            /* if function is found stop to traverse over structure */
            if(function->name == functionname && function->argnum == argnum) {
                break;                
            }
            /* got to next assigned function */
            function = function->next;
        }
    }

    if(argnum == 0) {
        void (*fn)(void*);
        fn = function->function;
        (*fn)(rec);
    } else if(argnum == 1) { 
        void (*fn)(void*,void*);
        fn = function->function;
        (*fn)(rec,argvalue);
    } else {
        printf("ERROR: To many arguments given '%i'\n",argnum);
    }

    return NULL;
}

int main(int argc, char *argv[]) {
    Function func2;
    func2.function = (FUNCTION) printMsgWithDots;
    func2.name = "printMsg";
    func2.argnum = 0;

    Function func1;
    func1.function = (FUNCTION) printMsg;
    func1.name = "printMsg";
    func1.argnum = 0;

    Object oldRect;
    oldRect.attribute = "Hello World by 'oldRect'!";
    oldRect.function = NULL;
    oldRect.proto = NULL;
    
    Object newRect;
    newRect.attribute = "Hello World by 'newRect'!";
    newRect.function = NULL;
    newRect.proto = NULL;
    
    newRect.proto = &oldRect;

    /* Now the important part */
    invoke(&oldRect, "printMsg", 0, NULL);
    
    printf("// Assigning 'printMsg' function to root-object.\n");
    oldRect.function = &func1;

    invoke(&oldRect, "printMsg", 0, NULL);
    invoke(&newRect, "printMsg", 0, NULL);
    
    /* Add the function to the  */
    printf("// Assigning different 'printMsg' function to child-object.\n");
    newRect.function = &func2;
    
    invoke(&oldRect, "printMsg", 0, NULL);
    invoke(&newRect, "printMsg", 0, NULL);

    return 0;
}
