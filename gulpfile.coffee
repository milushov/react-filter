gulp      = require 'gulp'
$         = require('gulp-load-plugins')
  lazy:    true
  pattern: ['gulp-*', 'main-bower-files', 'del', 'run-sequence']

pkg       = require './package.json'
cur_date  = -> new Date().toLocaleString()
banner    = -> "/*! #{ pkg.name } #{ pkg.version } #{cur_date()} */\n"
dest_path = 'app/public'

gulp.task 'clean', (cb) ->
  files = ['compiled_frontend', 'app/public/*.css', 'app/public/*.js']
  $.del files, cb
gulp.task 'remove_libs', (cb) -> $.del 'build/libs', cb

gulp.task 'coffee', ->
  gulp.src 'app/public/scripts/*.coffee'
    .pipe $.plumber()
    .pipe $.coffee(bare: true)
    .on('error', $.util.log)
    .pipe $.rename((path) -> path.dirname = '')
    .pipe gulp.dest('compiled_frontend/scripts')

gulp.task 'js', ->
  gulp.src 'compiled_frontend/scripts/*.js'
    .pipe $.concat('app.js')
    .pipe $.plumber()
    .pipe $.header(banner())
    .pipe gulp.dest('app/public')
    .pipe $.uglify()
    .pipe $.plumber()
    .pipe $.rename(suffix: '.min')
    .pipe gulp.dest('app/public')
    .pipe $.livereload()

gulp.task 'scripts', ->
  #$.runSequence 'coffee', 'js', 'browserify'
  $.runSequence 'browserify'

gulp.task 'styles', ->
  cssFilter  = $.filter '*.css'
  gulp.src 'app/public/styles/*.{sass,scss}'
    .pipe $.plumber()
    .pipe $.rubySass(style: 'expanded', 'sourcemap=none': true, precision: 2)
    .pipe cssFilter
    .pipe $.autoprefixer('last 3 version')
    .pipe $.concat('app.css')
    .pipe gulp.dest('app/public')
    .pipe $.minifyCss()
    .pipe $.rename(suffix: '.min')
    .pipe gulp.dest('app/public')
    .pipe $.livereload()

gulp.task 'browserify', ->
  gulp.src 'app/public/scripts/app.coffee'
    .pipe $.plumber()
    .pipe $.shell("
      ./node_modules/browserify/bin/cmd.js \
        -t ./node_modules/coffee-reactify/index.js \
        app/public/scripts/app.coffee -o app/public/app.js")
    .pipe $.plumber()
    .pipe $.livereload()

gulp.task 'build', ->
  $.runSequence  'libs'
  gulp.start ['libs', 'styles', 'scripts']

gulp.task 'libs', ['remove_libs'], ->
  $.runSequence 'get_libs', 'compile_libs'

# http://stackoverflow.com/a/24808013/1171144
# grab libraries files from bower_components, minify and push in /public
gulp.task 'get_libs', ->

  jsFilter   = $.filter '*.js'
  cssFilter  = $.filter '*.css'
  fontFilter = $.filter ['*.eot', '*.woff', '*.svg', '*.ttf']

  gulp.src($.mainBowerFiles())
    .pipe $.plumber()

    .pipe jsFilter
    .pipe gulp.dest('compiled_frontend/vendor')
    .pipe jsFilter.restore()

    .pipe cssFilter
    #.pipe $.debug()
    .pipe gulp.dest('compiled_frontend/vendor')
    .pipe cssFilter.restore()

    .pipe fontFilter
    .pipe gulp.dest('compiled_frontend/vendor')

gulp.task 'compile_libs', ->

  jsFilter   = $.filter '**/*.js'
  cssFilter  = $.filter '**/*.css'
  fontFilter = $.filter ['*.eot', '*.woff', '*.svg', '*.ttf']

  gulp.src 'compiled_frontend/vendor/**.*'
    .pipe $.plumber()
    .pipe jsFilter
    .pipe $.concat('vendor.js')
    .pipe gulp.dest(dest_path)
    .pipe $.uglify()
    .pipe $.rename(suffix: '.min')
    .pipe gulp.dest(dest_path)
    .pipe jsFilter.restore()

    .pipe cssFilter
    .pipe $.concat('vendor.css')
    .pipe gulp.dest(dest_path)
    .pipe $.minifyCss()
    .pipe $.rename(suffix: '.min')
    .pipe gulp.dest(dest_path)
    .pipe cssFilter.restore()

    .pipe fontFilter
    .pipe $.flatten()
    .pipe gulp.dest(dest_path + '/fonts')

gulp.task 'default', ['clean'], ->
  $.livereload.listen()
  gulp.start ['build']
  gulp.watch ['app/public/scripts/*.coffee', 'app/public/scripts/**/*.cjsx'], ['scripts']
  gulp.watch 'app/public/styles/*.{sass,scss}', ['styles']

