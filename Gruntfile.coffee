nconf = require 'nconf'
_ = require 'lodash'

module.exports = (grunt) ->

  # load all grunt tasks automatically, but exclude grunt-cli bc it's not a
  # grunt task
  require('matchdep').filterAll(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks);

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    ###### BUILD
    clean:
      build: ['public']

    webpack:
      options: require './assets/webpack.config.coffee'
      app:
        foo: 1

    ###### DEVELOPMENT
    watch:
      css:
        files: 'public/css/*.css'
        spawn: false
        options: { livereload: nconf.get('PORTS:livereload') }
      js_output:
        files: ['public/js/*.js', '!core-style.js']
        spawn: false
        options: { lovereload: nconf.get('PORTS:livereload') }
      views:
        files: 'views/**/*.jade'
        spawn: false
        options: { lovereload: nconf.get('PORTS:livereload') }


    # restart server when server files are modified
    nodemon:
      dev:
        script: 'app.coffee'
        options:
          ignore: ['node_modules/**', 'public/**', 'assets/**', 'bower_components/**']
          ext: 'js,coffee'
          # nodeArgs: ['--nodejs']
          # nodeArgs: ['--nodejs', '--debug='+nconf.get('PORTS:debug')]


    # start the node inspector which gives a debugger interface based on the
    # WebKit Web inspector
    'node-inspector':
      dev:
        options:
          'web-port': nconf.get('PORTS:inspector')
          'debug-port': nconf.get('PORTS:debug')


    concurrent:
      dev:
        tasks: ['nodemon', 'watch', 'node-inspector']
        options:
          logConcurrentOutput: true


  # Task aliases

  # Development tasks
  grunt.registerTask 'build-dev', ['clean:build', 'webpack'] # just start the server
  grunt.registerTask 'build', ['build-dev']

  grunt.registerTask 'dev', ['build-dev', 'concurrent:dev'] # build and start server

