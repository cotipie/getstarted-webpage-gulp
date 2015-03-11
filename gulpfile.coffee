gulp = require 'gulp'
bower = require 'gulp-bower-files'
flatten = require 'gulp-flatten'
uglify = require 'gulp-uglify'
autoprefixer = require 'gulp-autoprefixer'
sass = require 'gulp-sass'
del = require 'del'
runSequence = require 'run-sequence'
haml = require 'gulp-haml'
 
gulp.task 'bower', ->
  bower()
    .pipe flatten()
    .pipe (gulp.dest 'lib')

gulp.task 'fonts', ->
  gulp.src 'lib/fontawesome-webfont.*'
    .pipe (gulp.dest 'webdev/fonts')
  gulp.src 'lib/*.css'
    .pipe (gulp.dest 'webdev/css')

gulp.task 'jslib', ->
  gulp.src 'lib/*.js'
    .pipe (gulp.dest 'js')

gulp.task 'libclean', (cb)->
  del ['lib'], cb

gulp.task 'build:js',->
  gulp.src 'js/*.js'
    .pipe uglify({preserveComments:'some'})
    .pipe (gulp.dest 'webdev/js')

gulp.task 'build:sass',->
  gulp.src 'sass/**/*.scss'
    .pipe sass()
    .pipe autoprefixer('last 1 version')
    .pipe (gulp.dest 'webdev/css')

gulp.task 'build:haml', ->
  gulp.src 'haml/*.haml'
    .pipe haml({compiler:'creationix'})
    .pipe (gulp.dest 'webdev')

gulp.task 'initstart', (cb)->
  runSequence 'bower',['fonts','jslib'],'libclean',cb

gulp.task 'default', ->
	gulp.start 'build:sass','build:haml','build:js'

gulp.task 'watch', ->
	gulp.watch 'sass/**/*.scss',['build:sass']
	gulp.watch 'haml/*.haml',['build:haml']
	gulp.watch 'js/*.js',['build:js']