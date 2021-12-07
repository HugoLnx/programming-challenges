// https://www.beecrowd.com.br/judge/en/problems/view/1021
const util = require('util')
const process = require('process')
const infile = process.argv[2] || '/dev/stdin'
var input = require('fs').readFileSync(infile, 'utf8');
var lines = input.trim().split('\n').map(l => l.trim());

const COINS = [1, 0.50, 0.25, 0.10, 0.05, 0.01]
const NOTES = [100, 50, 20, 10, 5, 2]
const ALL = []
Array.prototype.push.apply(ALL, NOTES)
Array.prototype.push.apply(ALL, COINS)
ALL.sort((a,b) => a > b)

let val = lines.map(s => parseFloat(s))[0] * 100
let counts = {}
for (var i = 0; i < ALL.length; i++) {
    const coin = ALL[i]
    const amount = Math.floor(val / (coin*100))
    val -= amount * coin*100;
    counts[coin] = amount
}

console.log("NOTAS:")
for (var i = 0; i < NOTES.length; i++) {
    const coin = NOTES[i]
    console.log(`${counts[coin]} nota(s) de R$ ${coin.toFixed(2)}`)
}


console.log("MOEDAS:")
for (var i = 0; i < COINS.length; i++) {
    const coin = COINS[i]
    console.log(`${counts[coin]} moeda(s) de R$ ${coin.toFixed(2)}`)
}
