requireDir = require 'require-dir'

# Require all tasks in gulp/tasks, including subfolders
requireDir __dirname+'/gulp/tasks', { recurse: true }