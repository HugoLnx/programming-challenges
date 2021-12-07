// https://www.beecrowd.com.br/judge/en/problems/view/2544
const util = require('util')
const process = require('process')
const infile = process.argv[2] || '/dev/stdin'
var input = require('fs').readFileSync(infile, 'utf8');
var lines = input.trim().split('\n').map(l => l.trim());

const cases = lines.map(s => parseFloat(s))

let m = {}
m[0] = 0
m[1] = 0
function countCloning(n) {
    if (typeof(m[n]) === 'undefined') {
        m[n] = 1 + countCloning(n/2.0)
    }
    return m[n]
}


for (let i = 0; i < cases.length; i++) {
    const c = cases[i]

    process.stdout.write(`${countCloning(c)}\n`)
}