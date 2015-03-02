gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'
merge        = require 'merge2'
ts           = plugins.typescript


gulp.task 'source:views', false,()->
  files = ['./src/views/*.*','./src/views/**/*']
  gulp.src(files)
    .pipe(gulp.dest('./build/views'))
  

gulp.task 'source:typescript:backend', false,()->

  tsProject = ts.createProject({
    declarationFiles: true,
    noExternalResolve: false,
    module: 'commonjs'
  });
  
  files = [
    './src/**/*.ts',
    '!./src/assets/**/*.ts'
  ]
  
  tsResult = gulp.src(files).pipe(ts(tsProject))
  
  result =  merge([
    tsResult.dts.pipe(gulp.dest('build/definitions')),
    tsResult.js.pipe(gulp.dest('build/'))
  ])
  
  return result

gulp.task 'source:typescript:frontend', false,()->

  tsProject = ts.createProject({
    declarationFiles: true,
    noExternalResolve: false,
    module: 'commonjs'
  });

  files = [
    './src/assets/**/*.ts'
  ]
  tsResult = gulp.src(files).pipe(ts(tsProject))

  result =  merge([
    tsResult.dts.pipe(gulp.dest('build/definitions/public/assets')),
    tsResult.js.pipe(gulp.dest('build/public/assets/'))
  ])
  
  return result
  
gulp.task 'source',false,(cb)->
  runSequence(['source:typescript:backend','source:typescript:frontend','source:views'],cb)