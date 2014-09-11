/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

var app = new EmberApp();

app.import('bower_components/lodash/dist/lodash.js');

app.import('bower_components/bootstrap/dist/js/bootstrap.js');
app.import('bower_components/bootstrap/dist/css/bootstrap.css');

app.import('bower_components/jquery.cookie/jquery.cookie.js');

app.import('bower_components/omnibus/omnibus/static/omnibus/sockjs.js');
app.import('bower_components/omnibus/omnibus/static/omnibus/omnibus.js');

var fonts = pickFiles('bower_components/bootstrap/dist/fonts', {
    srcDir: '/',
    files: ['**/*'],
    destDir: '/fonts'
});

var bootstrapCssMap = pickFiles('bower_components/bootstrap/dist/css/', {
    srcDir: '/',
    files: ['bootstrap.css.map'],
    destDir: '/assets'
});

var tree = mergeTrees([app.toTree(), fonts, bootstrapCssMap]);

module.exports = tree;
