module.exports = (grunt) ->
  grunt.registerTask('asset-copy', ()->
    done = @async()
    cmds = [
      "cp -R vendor webapp/vendor"
      "cp -R vendor wp-theme/vendor"
      "cp -R webapp/assets wp-theme/assets"
    ].join(" && ")
    require('child_process').exec(cmds, (err, stdout, stderr)->
      if err then grunt.fatal(stderr)
      grunt.verbose.writeln(stdout)
      grunt.log.ok('\nAssets Copied')
      done()
    )

  )