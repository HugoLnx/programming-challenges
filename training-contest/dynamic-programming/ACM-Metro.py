# http://acm.timus.ru/problem.aspx?space=1&num=1119
import sys
sys.setrecursionlimit(10000)

def to_coordinates(str):
  x, y = str.split(" ")
  return (int(x), int(y))

width, height = to_coordinates(raw_input())
width = int(width)
height = int(height)

have_diagonal_to = [False] * (1001 * 1001)
for d in xrange(0, int(raw_input())):
  diagonal = to_coordinates(raw_input())
  have_diagonal_to[diagonal[0]+diagonal[1]*1001] = True

M = [None]*(1001*1001)
M[0] = 0

def short(x,y):
  if M[x+1001*y] is None:
    M[x+1001*y] = min( \
      short(x-1, y) + 100 if x >= 1 else float('inf'), \
      short(x, y-1) + 100 if y >= 1 else float('inf'), \
      short(x-1,y-1) + 141.4213562373095 if have_diagonal_to[x+y*1001] else float('inf') \
    )
  return M[x+1001*y]

print int(round(short(width, height)))
