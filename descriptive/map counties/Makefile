GENERATED_FILES = \
	us.json
 
.PHONY: all clean
 
all: $(GENERATED_FILES)
 
clean:
	rm -rf -- $(GENERATED_FILES) build
 
build/%.tar.gz:
	mkdir -p $(dir $@)
	curl -o $@ 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)'
 
build/counties-unfiltered.shp: build/countyp010_nt00795.tar.gz
	@rm -rf -- $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in `find $(basename $@) -type f`; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rm -rf -- $(basename $@)
 
build/counties.shp: build/counties-unfiltered.shp
	@rm -f -- $@
	ogr2ogr -f 'ESRI Shapefile' -where "FIPS NOT LIKE '%000'" $@ $<
 
us.json: build/counties.shp
	node_modules/.bin/topojson \
		-o $@ \
		--projection 'd3.geo.albersUsa()' \
		-q 1e5 \
		-s 1 \
		-p rate=+rate \
		--id-property=id,+FIPS \
		-- build/counties.shp