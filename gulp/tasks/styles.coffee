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
    .pipe(gulp.dest('./src/assets/tmp'))


  filesB = [
    './src/assets/css/**/*.css',
    '!./src/assets/css/style.css'
  ]

  streamB = gulp.src(filesB)
    .pipe(gulp.dest('./build/public/assets/css'))

  return merge([streamA,streamB])
  
gulp.task 'styles:fonts',false,(cb)->
  return gulp.src('./src/assets/fonts')
    .pipe(gulp.dest('./build/public/assets'))

gulp.task 'styles:images',false,(cb)->
  return gulp.src('./src/assets/images')
    .pipe(gulp.dest('./build/public/assets'))


gulp.task 'styles','Build stylesheets',(cb)->
  runSequence(['styles:compass','styles:images','styles:fonts'],cb)