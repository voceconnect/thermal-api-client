module.exports = (grunt) ->
  grunt.registerTask("make", [
    'asset-copy'
    'coffeelint'
    'coffee'
    'compass'
    'jst'
    'minified'
    'concat'
    'htmlmin'
    'img'
    'clean'
  ])