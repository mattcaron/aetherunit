SOURCES := $(wildcard *.d) $(wildcard utility/*.d) \
		$(wildcard controllers/*.d) $(wildcard models/*.d) \
		$(wildcard views/*.d)
OBJECTS := $(SOURCES:.d=.o)
TARGET := ../aetherunit
RESOURCE_DIR := ../resources

GTKD_DIR := $(HOME)/workspace/code/d/GtkD

DC := gdc

WIDGET_LIB_FLAGS := -I$(GTKD_DIR)/src \
                    -L$(GTKD_DIR) \
                    -lgtkd-2 -ldl

RESOURCE_FLAGS := -J$(RESOURCE_DIR)

DEBUG_FLAGS := -ggdb -fdebug=1

DFLAGS := -O2 -Wall -Werror $(DEBUG_FLAGS) \
          $(WIDGET_LIB_FLAGS) $(RESOURCE_FLAGS) 

all: $(TARGET)

clean:
	-rm $(TARGET) $(OBJECTS)

views/mainView.o: $(RESOURCE_DIR)/main.glade \
		  utility/accessorTemplate.d \
                  controllers/mainController.d
views/errorView.o: $(RESOURCE_DIR)/errorView.glade \
		   utility/accessorTemplate.d 
controllers/mainController.o: utility/accessorTemplate.d \
		              views/mainView.d \
			      views/errorView.d \
			      models/armyProfile.d \
	                      models/basicUnit.d \
		  	      models/supportUnit.d \
		              models/eliteUnit.d
models/armyProfile.o: utility/accessorTemplate.d \
                      models/statList.d
models/statList.o: utility/accessorTemplate.d
models/aetherVerseObject.o: utility/accessorTemplate.d \
		            models/armyProfile.d
models/unit.o: models/aetherVerseObject.d
models/basicUnit.o: models/unit.d
models/eliteUnit.o: models/unit.d
models/supportUnit.o: models/unit.d

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
%.o: %.d
	$(DC) -c -o $@ $< $(DFLAGS)

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
$(TARGET): $(OBJECTS)
	$(DC) -o $@ $(OBJECTS) $(DFLAGS)
