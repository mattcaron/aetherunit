TARGET := aetherunit

all: $(TARGET)

.PHONY: clean $(TARGET)

clean:
	make -C src clean

# IMPORTANT: Flags need to come AFTER target and sources for gdc 4.6
$(TARGET): 
	make -C src all

