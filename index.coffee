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
        'mcollina'
    ]

    try
        for candidate in expected
            check = teamGithubUsernames.indexOf(candidate) != -1
            assert.equal check, true, "'#{candidate}' is not member yet"

        assert.equal teamGithubUsernames.length, expected.length, "length does not match"
        console.log '\u001b[32m \u2714 passend'
    catch err
        console.log 'AssertionError:'
        console.log '  \u001b[31m' + err.message
        process.exit 1

    # reset CLI color
    console.log '\u001b[0m'
