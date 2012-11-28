dirs:
	@mkdir -p build
	@mkdir -p result

WebCssProvider: dirs
	valac ./src/WebCssProvider.vala --pkg gtk+-3.0 -o build/WebCssProvider

lessc:
	@make -C ./src/less

normalize.less: dirs
	@cp ./src/normalize/normalize.css ./build/normalize.less

style.less: dirs
	@echo '@import "normalize.less"; @import "$(name).less"; @import "src/$(name)-fix.less";' > build/style.less

less: dirs lessc style.less WebCssProvider normalize.less
	@./build/WebCssProvider $(name) $(variant) > build/$(name).less

css: less
	@./src/less/bin/lessc -O2 build/style.less result/$(name).css
	
Ambiance:
	@make css name=Ambiance variant=default

open-example:
	@gnome-open ./example/simple.html

clean:
	rm ./build -rf