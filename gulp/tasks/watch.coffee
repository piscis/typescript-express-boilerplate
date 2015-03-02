gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })

gulp.task 'watch', false, (cb)->

  server = plugins.developServer
  
  server.listen({path:'./build/app.js'},plugins.livereload.listen)
  
  gulp.watch ['./src/*.ts','./src/**/*.{ts,js}','!./src/assets/*.{ts,js}'], ['source:typescript:backend']

  gulp.watch ['!./src/**/*.{ts,js}','./src/assets/*.{ts,js}'], ['source:typescript:frontend']
    
  gulp.watch './src/**/*.{scss,sass}', ['styles:compass']
    
  gulp.watch './src/**/*.{png,jpg,jpeg,gif,svg}', ['source:images']
    
  gulp.watch './src/views/**/*.*', ['source:views']
    
  gulp.watch './src/assets/fonts/*.*', ['styles:fonts']
  
  gulp.watch(['./build/app.js','./build/**/*.js','!./build/public/**/*.*']).on 'change', (file)->

    server.changed (err)->
      if !err
        plugins.livereload.changed(file.path)
      else
        plugins.util.log err
        
  gulp.watch('./build/public/**/*.*').on 'change', (file)->
    plugins.livereload.changed(file.path)