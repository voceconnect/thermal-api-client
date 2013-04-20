module.exports = (grunt) ->
  grunt.registerTask('clean', ()->
    done = @async()
    cmds = [
      "find ./_build/js -type f -not -name 'wisp.js' | xargs rm"
    ].join(" && ")
    require('child_process').exec(cmds, (err, stdout, stderr)->
      if err then grunt.fatal(stderr)
      grunt.verbose.writeln(stdout)
      grunt.log.ok('\nUnused files removed')
      done()
    )
  )