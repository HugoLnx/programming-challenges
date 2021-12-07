// https://www.beecrowd.com.br/judge/en/problems/view/1012
const util = require('util')
const process = require('process')
const infile = process.argv[2] || '/dev/stdin'
var input = require('fs').readFileSync(infile, 'utf8');
var lines = input.split('\n').map(l => l.trim());

var [a, b, c] = lines[0].split(/\s+/).map(s => parseFloat(s))
const triangle = (a * c) / 2.0
const circle = 3.14159 * c*c
const trapezium = (a + b) * c / 2.0
const square = b * b
const rectangle = a * b


const out = util.format(`
TRIANGULO: %s
CIRCULO: %s
TRAPEZIO: %s
QUADRADO: %s
RETANGULO: %s
`.trim(), triangle.toFixed(3), circle.toFixed(3), trapezium.toFixed(3), square.toFixed(3), rectangle.toFixed(3))
process.stdout.write(`${out}\n`)