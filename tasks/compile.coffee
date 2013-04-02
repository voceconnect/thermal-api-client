module.exports = (grunt) ->
  grunt.registerTask("compile", [
    'coffeelint'
    'coffee'
    'compass'
    'img'
    'asset-copy'
  ])