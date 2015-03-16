gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
runSequence  = require 'run-sequence'
merge        = require 'merge2'

gulp.task 'styles:compass',false,(cb)->

  filesA = [
    './src/assets/**/*.sass'
    './src/assets/**/*.scss'
  ]
  
  streamA = gulp.src(filesA)
    .pipe(plugins.compass({
      css: 'build/public/assets/css',
      sass: 'src/assets/sass',
      image: 'src/assets/images',
      fonts: 'src/assets/fonts',
    }))
    .on('error', (err)->
      # Would like to catch the error here
      plugins.util.log(error);
      this.emit('end');
    )
    .pipe(plugins.if(global.conf.compress,plugins.minifyCss()))
    .pipe(gulp.dest('./src/assets/tmp'))


  filesB = [
    './src/assets/css/**/*.css',
    '!./src/assets/css/style.css'
  ]

  streamB = gulp.src(filesB)
    .pipe(plugins.if(global.conf.compress,plugins.minifyCss()))
    .pipe(gulp.dest('./build/public/assets/css'))

  return merge([streamA,streamB])
  
gulp.task 'styles:fonts',false,(cb)->
  return gulp.src('./src/assets/fonts')
    .pipe(gulp.dest('./build/public/assets'))

gulp.task 'styles:images',false,(cb)->
  return gulp.src('./src/assets/images')
    .pipe(plugins.if(global.conf.compress,plugins.imagemin()))
    .pipe(gulp.dest('./build/public/assets'))


gulp.task 'styles',false, (cb)->
  runSequence(['styles:compass','styles:images','styles:fonts'],cb)