# Generated on 2013-09-08 using generator-angular-ls 0.3.1
'use strict'

LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })
mountFolder = (connect, dir) -> connect.static(require('path').resolve(dir))

## # Globbing
## for performance reasons we're only matching one level down:
## 'test/spec/{,*/}*.js'
## use this if you want to recursively match all subfolders:
## 'test/spec/**/*.js'

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  # configurable paths
  yeomanConfig =
    app: 'app'
    dist: 'dist'
    tmp: '.tmp'

  try
    yeomanConfig.app = require('./bower.json').appPath || yeomanConfig.app

  grunt.initConfig(
    yeoman: yeomanConfig
    watch:
      coffee:
        files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee']
        tasks: ['coffee:dist']

      coffeeTest:
        files: ['test/spec/{,*/}*.coffee']
        tasks: ['coffee:test']

      ls:
        files: ['<%= yeoman.app %>/scripts/{,*/}*.ls']
        tasks: ['lsc:dist']

      lsTest:
        files: ['test/spec/{,*/}*.ls']
        tasks: ['lsc:test']


      recess:
        files: ['<%= yeoman.app %>/styles/{,*/}*.less']
        tasks: ['recess']


      styles:
        files: ['<%= yeoman.app %>/styles/{,*/}*.css']
        tasks: ['copy:styles', 'autoprefixer']

      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: [
          '<%= yeoman.app %>/{,*/}*.html'
          '<%= yeoman.tmp %>/styles/{,*/}*.css'
          '{<%= yeoman.tmp %>,<%= yeoman.app %>}/scripts/{,*/}*.js'
          '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
        ]

    "regex-replace":
      # patch bootstrap to use font-awesome
      bootsome:
        src: ['<%= yeoman.app %>/bower_components/bootstrap/less/bootstrap.less']
        actions:[
          name: 'font-awesome patch for bootstrap'
          search: '@import "sprites\\.less";'
          replace: '@import "../../font-awesome/less/font-awesome.less";'
          flags: 'gm'
        ]
      someboot:
        src: ['<%= yeoman.app %>/bower_components/font-awesome/less/variables.less']
        actions:[
          name: 'bootstrap patch for font-awesome',
          search: '@FontAwesomePath:\\s*"\\.\\.\\/font";'
          replace: '@FontAwesomePath:    "../bower_components/font-awesome/font";'
          flags: 'gm'
        ]

    autoprefixer:
      options: ['last 1 version']
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.tmp %>/styles/'
          src: '{,*/}*.css',
          dest: '<%= yeoman.tmp %>/styles/'
        ]

    connect:
      options:
        port: 9000
        # Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost'

      livereload:
        options:
          middleware: (connect) -> [
            lrSnippet
            mountFolder(connect, yeomanConfig.tmp)
            mountFolder(connect, yeomanConfig.app)
          ]

      test:
        options:
          port: 9001
          middleware: (connect) -> [
            mountFolder(connect, '<%= yeoman.tmp %>'),
            mountFolder(connect, 'test')
          ]

      dist:
        options:
          middleware: (connect) -> [
            mountFolder(connect, yeomanConfig.dist)
          ]

    open:
      server:
        url: 'http://localhost:<%= connect.options.port %>'

    clean:
      dist:
        files: [
          dot: true
          src: [
            '.tmp'
            '<%= yeoman.dist %>/*'
            '!<%= yeoman.dist %>/.git*'
          ]
        ]
      server: '<%= yeoman.tmp %>'

    jshint:
      options:
        jshintrc: '.jshintrc'

      all: [
        'Gruntfile.js'
        '<%= yeoman.app %>/scripts/{,*/}*.js'
      ]

    coffee:
      options:
        sourceMap: true
        sourceRoot: ''

      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/scripts'
          src: '{,*/}*.coffee'
          dest: '<%= yeoman.tmp %>/scripts'
          ext: '.js'
        ]

      test:
        files: [
          expand: true
          cwd: 'test/spec'
          src: '{,*/}*.coffee'
          dest: '<%= yeoman.tmp %>/spec'
          ext: '.js'
        ]

    lsc:
      options:
        # sourceMap: true
        # sourceRoot: ''
        bare: true
      
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/scripts'
          src: '{,*/}*.ls',
          dest: '<%= yeoman.tmp %>/scripts'
          ext: '.js'
        ]

      test:
        files: [
          expand: true
          cwd: 'test/spec'
          src: '{,*/}*.ls'
          dest: '<%= yeoman.tmp %>/spec'
          ext: '.js'
        ]


    recess:
      dist:
        options:
          compile: true
        files:
          '<%= yeoman.tmp %>/styles/main.css': ['<%= yeoman.app %>/styles/main.less']



    # not used since Uglify task does concat
    # but still available if needed
    #
    # concat:
    #  dist: {}
    #
    rev:
      dist:
        files:
          src: [
            '<%= yeoman.dist %>/scripts/{,*/}*.js'
            '<%= yeoman.dist %>/styles/{,*/}*.css'
            '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
            '<%= yeoman.dist %>/styles/fonts/*'
          ]

    useminPrepare:
      html: '<%= yeoman.app %>/index.html'
      options:
        dest: '<%= yeoman.dist %>'

    usemin:
      html: ['<%= yeoman.dist %>/{,*/}*.html']
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css']
      options:
        dirs: ['<%= yeoman.dist %>']

    imagemin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/images'
          src: '{,*/}*.{png,jpg,jpeg}'
          dest: '<%= yeoman.dist %>/images'
        ]

    svgmin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/images'
          src: '{,*/}*.svg'
          dest: '<%= yeoman.dist %>/images'
        ]

    cssmin: {}
      # By default, your `index.html` <!-- Usemin Block --> will take care of
      # minification. This option is pre-configured if you do not wish to use
      # Usemin blocks.
      # dist: {
      #   files: {
      #     '<%= yeoman.dist %>/styles/main.css': [
      #       '<%= yeoman.tmp %>/styles/{,*/}*.css'
      #       '<%= yeoman.app %>/styles/{,*/}*.css'
      #     ]
      #   }
      # }

    htmlmin:
      dist:
        options: {
          # /*removeCommentsFromCDATA: true
          # // https://github.com/yeoman/grunt-usemin/issues/44
          # //collapseWhitespace: true
          # collapseBooleanAttributes: true
          # removeAttributeQuotes: true
          # removeRedundantAttributes: true
          # useShortDoctype: true
          # removeEmptyAttributes: true
          # removeOptionalTags: true*/
        }
        files: [
          expand: true
          cwd: '<%= yeoman.app %>'
          src: ['*.html', 'views/*.html']
          dest: '<%= yeoman.dist %>'
        ]

    # Put files not handled in other tasks here
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>'
          src: [
            '*.{ico,png,txt}'
            '.htaccess',
            'bower_components/**/*'
            'images/{,*/}*.{gif,webp}'
            'styles/fonts/*'
          ]
        ,
          expand: true,
          cwd: '<%= yeoman.tmp %>/images'
          dest: '<%= yeoman.dist %>/images'
          src: [
            'generated/*'
          ]
        ]

      styles:
        expand: true,
        cwd: '<%= yeoman.app %>/styles'
        dest: '<%= yeoman.tmp %>/styles/'
        src: '{,*/}*.css'

    concurrent:
      server: [
        'lsc:dist'

        'recess'

        'copy:styles'
      ]
      test: [
        'lsc'

        'recess'

        'copy:styles'
      ]
      dist: [
        'lsc'

        'recess'

        'copy:styles'
        'imagemin'
        'svgmin'
        'htmlmin'
      ]

    karma:
      unit:
        configFile: 'karma.conf.js'
        singleRun: false
        autoWatch: true
      ci:
        configFile: 'karma.conf.js'
        singleRun: true

    cdnify:
      dist:
        html: ['<%= yeoman.dist %>/*.html']

    ngmin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.dist %>/scripts'
          src: '*.js'
          dest: '<%= yeoman.dist %>/scripts'
        ]

    uglify:
      dist:
        files:
          '<%= yeoman.dist %>/scripts/scripts.js': [
            '<%= yeoman.dist %>/scripts/scripts.js'
          ]
  )

  grunt.registerTask('server', (target) ->
    if (target == 'dist')
      return grunt.task.run(['build', 'open', 'connect:dist:keepalive'])

    grunt.task.run([
      'clean:server'
      'concurrent:server'
      'regex-replace'
      'autoprefixer'
      'connect:livereload'
      'open'
      'watch'
    ])
  )

  grunt.registerTask('test', [
    'clean:server'
    'concurrent:test'
    'autoprefixer'
    'connect:test'
    'karma:unit'
  ])

  grunt.registerTask('build', [
    'clean:dist'
    'useminPrepare'
    'concurrent:dist'
    'regex-replace'
    'autoprefixer'
    'concat'
    'copy:dist'
    'cdnify'
    'ngmin'
    'cssmin'
    'uglify'
    'rev'
    'usemin'
  ])

  grunt.registerTask('default', [
    'jshint'
    'test'
    'build'
  ])
