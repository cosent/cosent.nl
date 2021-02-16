JEKYLL_VERSION=3.8


serve:
	docker run --rm \
	  --volume="$(PWD):/srv/jekyll" \
	  --volume=/var/tmp/bundle:/usr/local/bundle \
	  --net=host \
	  -it jekyll/jekyll:$(JEKYLL_VERSION) \
	  jekyll serve --watch
