// https://www.beecrowd.com.br/judge/en/problems/view/1001
const util = require('util')
const process = require('process')
const infile = process.argv[2] || '/dev/stdin'
var input = require('fs').readFileSync(infile, 'utf8');
var lines = input.split('\n').map(l => l.trim());

var [a, b] = lines.map(s => parseFloat(s))

const out = util.format('X = %d', a + b)
process.stdout.write(`${out}\n`)