SOURCES := $(wildcard *.d) $(wildcard utility/*.d)
OBJECTS := $(SOURCES:.d=.o)
TARGET := ../aetherunit
RESOURCE_DIR := ../resources

GTKD_DIR := $(HOME)/workspace/code/d/GtkD

DC := gdc

WIDGET_LIB_FLAGS := -I$(GTKD_DIR)/src \
                    -L$(GTKD_DIR) \
                    -lgtkd-2 -ldl

RESOURCE_FLAGS := -J$(RESOURCE_DIR)

DFLAGS := -O2 -Wall -Werror -fdebug=1 \
          $(WIDGET_LIB_FLAGS) $(RESOURCE_FLAGS) 

all: $(TARGET)

clean:
	-rm $(TARGET) $(OBJECTS)

mainView.o: mainView.d utility/accessorTemplate.d armyProfile.d \
	    $(RESOURCE_DIR)/main.glade mainController.d
mainController.o: mainController.d utility/accessorTemplate.d \
		  armyProfile.d mainView.d statList.d
armyProfile.o: utility/accessorTemplate.d statList.d
statList.o: utility/accessorTemplate.d
aetherVerseObject.o: aetherVerseObject.d utility/accessorTemplate.d \
		     armyProfile.d
unit.o: aetherVerseObject.d
basicUnit.o: unit.d
eliteUnit.o: unit.d
supportUnit.o: unit.d

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
%.o: %.d
	$(DC) -c -o $@ $< $(DFLAGS)

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
$(TARGET): $(OBJECTS)
	$(DC) -o $@ $(OBJECTS) $(DFLAGS)
