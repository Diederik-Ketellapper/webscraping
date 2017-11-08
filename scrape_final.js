var url ='https://sports.bwin.com/en/sports/search?query=barcelona';
var page = new WebPage()
var fs = require('fs');


page.open(url, function (status) {
        just_wait();
});

function just_wait() {
    setTimeout(function() {
               fs.write('1.html', page.content, 'w');
            phantom.exit();
    }, 2500);
}
