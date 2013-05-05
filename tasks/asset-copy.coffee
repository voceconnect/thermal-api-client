module.exports = (grunt) ->
  grunt.registerTask('asset-copy', ()->
    done = @async()
    cmds = [
      "rm -rf _build"
      "mkdir _build"
      "cp -r vendor/js _build/"
      "cp -r vendor/img _build/"
      "cp -r app/img _build/"
      "cp -r app/fonts _build/"
      "cp sample/index.html _build/"
    ].join(" && ")
    require('child_process').exec(cmds, (err, stdout, stderr)->
      if err then grunt.fatal(stderr)
      grunt.verbose.writeln(stdout)
      grunt.log.ok('\nAssets Copied')
      done()
    )
  )