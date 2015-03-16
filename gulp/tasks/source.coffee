gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'
merge        = require 'merge2'
ts           = plugins.typescript
merge        = require 'merge2'

gulp.task 'source:views', false,(cb)->
  
  files = ['!./src/views/base.ejs','./src/views/*.*','./src/views/**/*']
  gulp.src(files)
    .pipe(gulp.dest('./build/views'))
  

gulp.task 'source:typescript:backend', false, ()->

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
    tsResult.js
      .pipe(plugins.jshint())
      .pipe(plugins.jshint.reporter('jshint-stylish'))
      .pipe(plugins.if(global.conf.compress, plugins.uglify()))
      .pipe(gulp.dest('build/'))
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
    tsResult.js
      .pipe(plugins.jshint())
      .pipe(plugins.jshint.reporter('jshint-stylish'))
      .pipe(plugins.if(global.conf.compress, plugins.uglify()))
      .pipe(gulp.dest('build/public/assets/'))
  ])
  
  return result
  
gulp.task 'source:bower',false,(cb)->

  streamA = plugins.bower({ cmd: 'install'})
    .pipe(plugins.rename((path) ->

      if (~path.dirname.indexOf('fonts'))
        path.dirname = '/fonts'
      return path
    ))
    .pipe(plugins.ignore.exclude(['**/*.{css,js,md,txt,json,less,sass,scss,map,yml}','**/.*','**/LICENSE']))
    .pipe(gulp.dest("./build/public/vendor"))


  streamB = gulp.src('./src/views/base.ejs')
    .pipe(plugins.usemin({
        assetsDir: './',
        css: [plugins.if(global.conf.compress,plugins.minifyCss()), 'concat', gulp.dest('./build/public/')],
        js: [plugins.if(global.conf.compress, plugins.uglify()), 'concat', gulp.dest('./build/public/')]
    }))
    .pipe(plugins.ignore.exclude(['**/*.{css,js}']))
    .pipe(gulp.dest('./build/views/'))
  
  return merge([streamA,streamB])
  
gulp.task 'source',false,(cb)->
  runSequence(['source:typescript:backend','source:typescript:frontend','source:views','source:bower'],cb)