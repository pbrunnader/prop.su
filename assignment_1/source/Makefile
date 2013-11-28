CFLAGS=-std=c99 -Wall
CC=clang

TARGET=inheritance
OBJ=inheritance.o 

$(TARGET): $(OBJ)
	@echo 'Building target: $@'
	$(CC)  -o $@ $(OBJ) $(CFLAGS)
	@echo 'Finished building target: $@'

run: $(TARGET)
	./$(TARGET);
	rm *.o $(TARGET)
    

clean:
	rm *.o $(TARGET)



