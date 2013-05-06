module.exports = (grunt) ->
  grunt.registerTask("make", [
    'asset-copy'
    'coffeelint'
    'coffee'
    'compass'
    'jst'
    'concat'
    'minified'
    'htmlmin'
    'clean'
  ])