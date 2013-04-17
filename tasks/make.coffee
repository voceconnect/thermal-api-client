module.exports = (grunt) ->
  grunt.registerTask("make", [
    'coffeelint'
    'coffee'
    'compass'
    'img'
    'asset-copy'
  ])