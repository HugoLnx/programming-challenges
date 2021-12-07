// https://www.beecrowd.com.br/judge/en/problems/view/1015
const util = require('util')
const process = require('process')
const infile = process.argv[2] || '/dev/stdin'
var input = require('fs').readFileSync(infile, 'utf8');
var lines = input.split('\n').map(l => l.trim());

var [x1, y1] = lines[0].split(/\s+/).map(s => parseFloat(s))
var [x2, y2] = lines[1].split(/\s+/).map(s => parseFloat(s))

const distance = Math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))
const out = util.format('%s', distance.toFixed(4))
process.stdout.write(`${out}\n`)