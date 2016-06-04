SUBDIRS=tools/makeadf \
	tools/imagecon\
	tools/mapgen\
	tools/fade\
	tools/resize\
	tools/croppa\
	game

.PHONY: subdirs $(SUBDIRS)

all: subdirs

clean:
	for dir in $(SUBDIRS); do \
		echo Cleaning $$dir; \
		make -C $$dir clean; \
	done
	rm -f *~

subdirs: $(SUBDIRS)

$(SUBDIRS):
	@echo ""
	make -C $@

