var gulp = require('gulp');
var nymph = require('./nymph.js');

gulp.task('default', function() {
    console.log('hello world');
});

gulp.task('begin', function() {
    nymph.begin_to_interpret_threaded_code();
});


gulp.task('test', function() {

});
