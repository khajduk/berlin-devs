request = require 'superagent'
cheerio = require 'cheerio'
assert = require 'assert'

url = 'http://rplan.net/de/team/index.html'
request.get url, (err, res) ->
    if err?
        console.log "could load data from: #{url}"
        throw err

    html = res.text
    $ = cheerio.load html
    
    teamGithubUsernames = $('.fa-github').map( ->
        $(this).parent().attr('href').substr 'https://github.com/'.length
    ).get()

    console.log "fetched #{teamGithubUsernames.length} team members"

    expected = [ 
        'marcmenn'
        'lbilharz'
        'mwanser'
        'lcziegler'
        'andirotter'
        'koellcode'
        'miajulika'
        'mkronschnabl'
        'jumee'
        'timaschew'
        'katrinkat'
        'fschoenfelder'
        'kenansulayman'
    ]

    try
        for canidate in expected
            check = teamGithubUsernames.indexOf(canidate) != -1
            assert.equal check, true, "'#{canidate}' is not member yet"

        console.log '\u001b[32m \u2714 passend'
    catch err
        console.log 'AssertionError:'
        console.log '  \u001b[31m' + err.message
