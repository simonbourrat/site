const gulp = require('gulp');
const usemin = require('gulp-usemin');
const uglify = require('gulp-uglify');
const cleanCss = require('gulp-clean-css');
const rev = require('gulp-rev');
const flatten = require('gulp-flatten');
const urlAdjuster = require('gulp-css-url-adjuster');

let sources = ['assets/js/*.js', 'assets/lib/**/*.js', '*.html'];

gulp.task('compress', function() {
    return gulp.src('./_site/*.html')
        .pipe(usemin({
            jsAttributes: {defer: true},
            js: [uglify, rev],
            // jsAttributes: {async: true},
            css: [function() {return cleanCss()}, rev],

            inlinecss: [function(){return urlAdjuster({prependRelative: 'assets/'})},function() {return cleanCss()}]
        }))
        .pipe(gulp.dest('./_site/'));
});

gulp.task('fonts', function() {
    return gulp.src('./assets/lib/**/*.+(woff|woff2|eot|svg|ttf)')
        .pipe(flatten())
        .pipe(gulp.dest('./_site/fonts'));
});

gulp.task('default', ['compress', 'fonts']);