var url ='https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298';
var page = new WebPage()
var fs = require('fs');


page.open(url, function (status) {
        just_wait();
});

function just_wait() {
    setTimeout(function() {
               fs.write('1.html', page.content, 'w');
            phantom.exit();
    }, 5000);
}
