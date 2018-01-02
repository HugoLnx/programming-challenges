# https://www.hackerrank.com/challenges/fibonacci-modified
inputs = raw_input().split(" ")
a = int(inputs[0])
b = int(inputs[1])
n = int(inputs[2])

M = {}
def fib(a, b, n):
    if M.get(n) is not None:
        return M[n]
    elif n == 1:
        M[1] = a
    elif n == 2:
        M[2] = b
    else:
        M[n] = fib(a, b, n-1)**2 + fib(a, b, n-2)
    return M[n]

print fib(a, b, n)
