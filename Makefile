MAKE_FLAGS=-j5

all: clean
	mkdir -p build
	cd build; cmake ..
	cd build; ${MAKE} ${MAKE_FLAGS}

clean:
	rm -Rf build

forceclean: clean
	rm -Rf humoto

update:
	git submodule update --init

rebuild: clean all
