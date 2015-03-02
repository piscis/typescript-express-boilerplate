gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'
del          = require 'del'

gulp.task 'clean:build',false, (cb)->
  del(['build/*.*','build/**','build/**/*.*'],cb)

gulp.task 'clean:release',false, (cb)->
  del(['release/*.*','release/**','release/**/*.*'],cb)

gulp.task 'clean:all',false, (cb)->
  runSequence(['clean:build','clean:release'],cb)