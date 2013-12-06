/**
 * This is the "assignment 1" for the course "Programming languages and Paradigms" 
 * at the Stockholm University 
 *
 * assigment 1
 * inheritance
 *
 * @author Peter Brunnader 
 * @author Katrin Freihofner
 * @version 1.0
 **/

#include <stdio.h>

#define METHOD void*

typedef struct _Method
{
    void *method;
    char* name;
    int argnum;
    void* next;
} Method;

typedef struct _Class
{
    void* super;
    Method* firstMethod;
} Class;

typedef struct _Object {
    Class* class;
    char* msg;
} Object;

void printMsg(Object* self){
    puts(self->msg);
}

void setMsg(Object* self, char* msg) {
    self->msg = msg;
}

void* invoke(void* receiver, char* methodname, int argnum, void* argvalue) {
    Object* obj = receiver;
    Class* class = obj->class;
    Method* method = class->firstMethod;

    /* endless loop for traversing over classes and methods */
    while(1) {
        /* if class does not have any methods assigned */
        if(method == NULL) {
            /* if not root class then traverse to next parent class */
            if(class->super != NULL) {
                class = class->super;
                method = class->firstMethod;
                continue;
            } else {
                printf("ERROR: Method not found '%s'\n",methodname);
                return NULL;
            }
        } else {
            /* if method is found stop to traverse over structure */
            if(method->name == methodname && method->argnum == argnum) {
                break;                
            }
            /* got to next assigned method */
            method = method->next;
        }
    }
    
    /* call of matching method with NO arguments */
    if(argnum == 0) {
        void (*fn)(void*);
        fn = method->method;
        (*fn)(obj);
        /* call of matching method with ONE argument */
    } else if(argnum == 1) { 
        void (*fn)(void*,void*);
        fn = method->method;
        (*fn)(obj,argvalue);
    } else {
        printf("ERROR: To many arguments given '%i'",argnum);
    }

    return NULL;
}


int main(int argc, char *argv[]) {
    /* definition of the 'setMsg' method */
    Method method2;
    method2.method = (METHOD) setMsg;
    method2.name = "setMsg";
    method2.argnum = 1;
    method2.next = NULL;

    /* definition of the 'printMsg' method */
    Method method;
    method.method = (METHOD) printMsg;
    method.name = "printMsg";
    method.argnum = 0;
    method.next = &method2;

    /* definition of the root-class */
    Class class1;
    class1.super = NULL;
    /* assigning the two methods to the root-class */
    class1.firstMethod = &method;

    /* definition of the child-class of the root-class */
    Class class2;
    class2.super = &class1;
    /* no additional methods assigned */
    class2.firstMethod = NULL;

    /* creation of an object of the child-class */
    Object obj;
    obj.class = &class2;

    /* Now the important part */
    invoke(&obj, "setMsg", 1, "Hello, world");
    invoke(&obj, "printMsg", 0, NULL);
    invoke(&obj, "setMsg", 1, "This is another message");
    invoke(&obj, "printMsg", 0, NULL);
    
    return 0;
}
