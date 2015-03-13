gulp = require 'gulp'
bower = require 'gulp-bower-files'
flatten = require 'gulp-flatten'
uglify = require 'gulp-uglify'
autoprefixer = require 'gulp-autoprefixer'
sass = require 'gulp-sass'
del = require 'del'
runSequence = require 'run-sequence'
haml = require 'gulp-haml'
browserSync = require 'browser-sync'
imagemin = require 'gulp-imagemin'
 
gulp.task 'bower', ->
  bower()
    .pipe flatten()
    .pipe (gulp.dest 'lib')

gulp.task 'fonts', ->
  gulp.src 'lib/fontawesome-webfont.*'
    .pipe (gulp.dest 'dist/fonts')
  gulp.src 'lib/*.css'
    .pipe (gulp.dest 'dist/css')

gulp.task 'jslib', ->
  gulp.src 'lib/*.js'
    .pipe uglify({preserveComments:'some'})
    .pipe (gulp.dest 'dist/js')

gulp.task 'libClean', (cb)->
  del ['lib'], cb

gulp.task 'releaseClean', (cb)->
  del ['dist'], cb

gulp.task 'build:js',->
  gulp.src 'js/*.js'
    .pipe uglify({preserveComments:'some'})
    .pipe (gulp.dest 'dist/js')

gulp.task 'build:sass',->
  gulp.src 'sass/**/*.scss'
    .pipe sass()
    .pipe autoprefixer('last 1 version')
    .pipe (gulp.dest 'dist/css')

gulp.task 'build:html', ->
  gulp.src 'haml/*.html'
    .pipe (gulp.dest 'dist')

gulp.task 'build:haml', ->
  gulp.src 'haml/*.haml'
    .pipe haml({compiler:'creationix'})
    .pipe (gulp.dest 'dist')

gulp.task 'imagemin', ->
  gulp.src 'images/{,**/}*.{png,jpg,gif}'
    .pipe imagemin()
    .pipe (gulp.dest 'dist/images')

gulp.task 'server', ->
  browserSync({
    notify: false,
    server: {
      baseDir: "dist"
  	}
  })

gulp.task 'build:src', (cb)->
  runSequence 'build:haml','build:html',cb

gulp.task 'getstart', (cb)->
  runSequence 'bower',['fonts','jslib'],'default',cb

gulp.task 'default', ->
	gulp.start 'build:sass','build:src','build:js','imagemin'

gulp.task 'release', (cb)->
  runSequence 'releaseClean','bower',['fonts','jslib'],'libClean','default',cb 

gulp.task 'watch',->
	gulp.start 'server'
	gulp.watch 'sass/**/*.scss',['build:sass',browserSync.reload]
	gulp.watch 'haml/*.{haml,html}',['build:src',browserSync.reload]
	gulp.watch 'js/*.js',['build:js',browserSync.reload]
	gulp.watch 'images/{,**/}*.{png,jpg,gif}',['imagemin',browserSync.reload]