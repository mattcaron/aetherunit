SOURCES := $(wildcard src/*.d)
OBJECTS := $(SOURCES:.d=.o)
TARGET := aetherunit
GTKD_DIR := $(HOME)/workspace/code/d/GtkD

DC := gdc

WIDGET_LIB_FLAGS := -I$(GTKD_DIR)/src \
                    -L$(GTKD_DIR) \
                    -lgtkd-2 -ldl

RESOURCE_FLAGS := -J$(PWD)/resources

DFLAGS := -O2 -Wall -Werror -fdebug=1 \
          $(WIDGET_LIB_FLAGS) $(RESOURCE_FLAGS)

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
%.o: %.d
	$(DC) -c -o $@ $< $(DFLAGS)

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
$(TARGET): $(OBJECTS)
	$(DC) -o $@ $(OBJECTS) $(DFLAGS)

all: $(TARGET)

clean:
	-rm $(TARGET) $(OBJECTS)
