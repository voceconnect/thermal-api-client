//runspecs.js

//fake browser window
global.window = require("jsdom")
    .jsdom()
    .createWindow();
global.jQuery = require("jquery");

//Test framework
var jasmine=require('jasmine-node');
for(var key in jasmine) {
    global[key] = jasmine[key];
}

//What we're testing
require("./placeholder.js")

jasmine.executeSpecsInFolder(__dirname + '/tests/specs', function(runner, log){
    process.exit(runner.results().failedCount?1:0);
}, true, true);