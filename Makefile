SUBDIRS=tools/makeadf \
	tools/imagecon\
	tools/mapgen\
	tools/fade\
	tools/resize\
	tools/croppa

.PHONY: subdirs $(SUBDIRS)

all: game

clean:
	for dir in $(SUBDIRS); do \
		echo Cleaning $$dir; \
		make -C $$dir clean; \
	done
	make -C game clean
	rm -f *~

game: $(SUBDIRS)
	make -C game all

$(SUBDIRS):
	@echo ""
	make -C $@

