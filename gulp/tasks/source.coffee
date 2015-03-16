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
  
gulp.task 'source:bower',false,(cb)->
  
  jsFilter = plugins.filter('**/*.min.js')
  cssFilter = plugins.filter('**/*.min.css')
  
  return plugins.bower({ cmd: 'install'})
    .pipe(jsFilter)
    .pipe(plugins.concat('vendor.js'))
    .pipe(gulp.dest("./build/public/components"))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe(plugins.concat('vendor.css'))
    .pipe(gulp.dest("./build/public/components"))
    .pipe(cssFilter.restore())
    .pipe(plugins.rename((path) ->
      
      if (~path.dirname.indexOf('fonts'))
        path.dirname = '/fonts'
      return path
    ))
    .pipe(gulp.dest("./build/public/components"))
  
  
gulp.task 'source',false,(cb)->
  runSequence(['source:typescript:backend','source:typescript:frontend','source:views','source:bower'],cb)