/**
 * This is the "assignment 0" for the course "Programming languages and Paradigms" 
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
#include <string.h>

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
void* invoke(void* receiver, char* methodname, int argnum, void* argvalue){
    Object* obj = receiver;
    Class* class = obj->class;
    Method* method = class->firstMethod;

    while (method != NULL) {
        if(method->name == methodname && method->argnum == argnum) {
            break;
        }

        method = method->next;
        if(method == NULL) {
           if(class->super != NULL) {
                class = class->super;
                method = class->firstMethod;
            }else{
                break;
            }
        }
    }

    if(argnum == 0) {
        void (*fn)(void*);
        fn = method->method;
        (*fn)(obj);
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
    Method method2;
    method2.method = (METHOD) setMsg;
    method2.name = "setMsg";
    method2.argnum = 1;
    method2.next = NULL;

    Method method;
    method.method = (METHOD) printMsg;
    method.name = "printMsg";
    method.argnum = 0;
    method.next = &method2;

    Class class;
    class.super = NULL;
    class.firstMethod = &method;

    Object obj;
    obj.class = &class;

    /* Now the important part */
    invoke(&obj, "setMsg", 1, "Hello, world");
    invoke(&obj, "printMsg", 0, NULL);
    invoke(&obj, "setMsg", 1, "This is another message");
    invoke(&obj, "printMsg", 0, NULL);
    
    return 0;
}
