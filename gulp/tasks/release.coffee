gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })


gulp.task 'release:source', false,(cb)->

  cssFilter = plugins.filter('**/*.css');
  
  return gulp.src(['./build/**/*.*','!./build/definitions/**/*.*'])
    .pipe(cssFilter)
    .pipe(plugins.if(global.conf.compress,plugins.minifyCss()))
    .pipe(cssFilter.restore())
    .pipe(gulp.dest('./release'))