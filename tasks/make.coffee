module.exports = (grunt) ->
  grunt.registerTask("make", [
    'asset-copy'
    'coffee'
    'compass'
    'jst'
    'minified'
    'concat'
    'htmlmin'
    'clean'
  ])
