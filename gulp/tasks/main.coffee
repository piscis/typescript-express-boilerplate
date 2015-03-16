gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'


global.conf = {
  compress: false
}

gulp.task 'build', false, (cb)->
  runSequence('clean:all', ['source','styles'], cb)

gulp.task 'dist', 'Prepare a release build', (cb)->
  global.conf.compress = true
  runSequence('build','release:source', 'version:bump', cb)

gulp.task 'dev', 'Default task used for development', (cb)->
  runSequence('build','watch', cb)