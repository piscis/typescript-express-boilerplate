gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'

gulp.task 'build', false, (cb)->
  runSequence('clean:all', ['source','styles'], cb)

gulp.task 'release', 'Prepare a release build', (cb)->
  runSequence('build','version:release', cb)

gulp.task 'develop', 'Default task used for development', (cb)->
  runSequence('build','watch', cb)