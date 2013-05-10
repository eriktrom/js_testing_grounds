// Karma configuration
// Generated on Fri Apr 26 2013 21:55:24 GMT-1000 (HST)


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser
files = [
  'public/vendor/q.js',
  // 'public/vendor/jquery-1.9.1.js',
  // 'public/vendor/rsvp.js',
  MOCHA,
  MOCHA_ADAPTER,
  'public/vendor/mocha-as-promised.js',
  'public/vendor/chai.js',
  'public/vendor/chai-as-promised.js',
  'public/vendor/sinon-chai.js',
  'public/vendor/sinon-1.6.0.js',
  'coffee/**/*_mocha_test.coffee'
];

// try using the es6-module-transpiler:
// http://square.github.io/es6-module-transpiler/
// compile-modules --type cjs --to output input
//
// Examples:
// import "jquery" as jQuery;          // Import module as a variable
// import Point from "math";           // Import one part of a module
// import { sqrt, Point } from "math"; // Import multiple parts of a module
// export = jQuery;                    // Export an object as the module
// export Point;                       // Export an object as a module property
// export { sqrt, Point };             // Export multiple objects as module properties

// list of files to exclude
exclude = [

];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress', 'growl'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['ChromeCanary'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
