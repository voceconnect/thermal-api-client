module.exports = (grunt) ->
  grunt.registerTask('asset-copy', ()->
    done = @async()
    cmds = [
      "cp -R vendor/js _build/"
      "cp -R vendor/images _build/"
      "cp -R vendor/css _build/"
      "cp index.html _build/"
    ].join(" && ")
    require('child_process').exec(cmds, (err, stdout, stderr)->
      if err then grunt.fatal(stderr)
      grunt.verbose.writeln(stdout)
      grunt.log.ok('\nAssets Copied')
      done()
    )
  )