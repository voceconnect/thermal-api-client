# Require any additional compass plugins here.


# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "_build/css"
sass_dir = "app/sass"
images_dir = "_build/img"
fonts_dir = "_build/fonts"

# disable asset cache buster
asset_cache_buster do |http_path, real_path|
  nil
end

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass
