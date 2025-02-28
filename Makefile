CC = gcc
TARGET = wts

# Define paths
WEBTS_DIR = webtimeserver/webtimeserver/webtimeserver
THREADPOOL_DIR = default/threadpool
PROPERTIES_DIR = default/properties
DEBUG_DIR = webtimeserver/webtimeserver/debug

# Define object files
OBJECTS = $(WEBTS_DIR)/webtimeserver.o \
          $(THREADPOOL_DIR)/threadpool.o \
          $(PROPERTIES_DIR)/properties.o

LDFLAGS = -lws2_32

# Target rule
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $@ $^ -lpthread $(LDFLAGS)

# Compilation rules for each object file
$(WEBTS_DIR)/webtimeserver.o: $(WEBTS_DIR)/webtimeserver.c $(WEBTS_DIR)/webtimeserver.h $(DEBUG_DIR)/dbg.h
	$(CC) -c $(WEBTS_DIR)/webtimeserver.c -o $(WEBTS_DIR)/webtimeserver.o

$(THREADPOOL_DIR)/threadpool.o: $(THREADPOOL_DIR)/threadpool.c $(THREADPOOL_DIR)/threadpool.h $(DEBUG_DIR)/dbg.h
	$(CC) -c $(THREADPOOL_DIR)/threadpool.c -o $(THREADPOOL_DIR)/threadpool.o

$(PROPERTIES_DIR)/properties.o: $(PROPERTIES_DIR)/properties.c $(PROPERTIES_DIR)/properties.h $(DEBUG_DIR)/dbg.h
	$(CC) -c $(PROPERTIES_DIR)/properties.c -o $(PROPERTIES_DIR)/properties.o

# Dependency rules
%.d: %.c
	$(CC) -MM $< > $@

-include $(OBJECTS:.o=.d)

# Clean rule
clean:
ifeq ($(OS),Windows_NT)
	del /f /q *.o 2>nul
else
	rm -f *.o
endif
