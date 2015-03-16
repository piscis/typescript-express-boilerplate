gulp         = require('gulp-help')(require('gulp'))
plugins      = require('gulp-load-plugins')({ camelize: true })
del          = require('del')
vinylPaths   = require('vinyl-paths')
merge        = require 'merge2'

promptBump = (callback) ->
  prompt = require('gulp-prompt')
  semver = require('semver')
  pkg = require('./../../package.json')

  return gulp.src('')
    .pipe(prompt.prompt({
        type: 'list',
        name: 'bump',
        message: 'What type of version bump would you like to do ? (current version is ' + pkg.version + ')',
        choices: [
          'patch (' + pkg.version + ' --> ' + semver.inc(pkg.version, 'patch') + ')',
          'minor (' + pkg.version + ' --> ' + semver.inc(pkg.version, 'minor') + ')',
          'major (' + pkg.version + ' --> ' + semver.inc(pkg.version, 'major') + ')',
          'none (exit)'
        ]
      }, (res) ->
        newVer
        if(res.bump.match(/^patch/))
          newVer = semver.inc(pkg.version, 'patch')
        else if(res.bump.match(/^minor/))
          newVer = semver.inc(pkg.version, 'minor')
        else if(res.bump.match(/^major/))
          newVer = semver.inc(pkg.version, 'major')

        if(newVer && typeof callback == 'function')
          return callback(newVer)
        else
          return
    ))
  
gulp.task 'version:bump', false, (cb) ->
  jeditor = require("gulp-json-editor")

  return promptBump (newVer)->

    #update the main project version number
    streamB = gulp.src('./package.json')
      .pipe(jeditor({
        'version': newVer
      }))
      .pipe(gulp.dest("./"))


    streamA =   gulp.src('./bower.json')
      .pipe(jeditor({
        'version': newVer
      }))
      .pipe(gulp.dest("./"))

    return merge([streamA,streamB]);
