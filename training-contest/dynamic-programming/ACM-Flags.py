# http://acm.timus.ru/problem.aspx?space=1&num=1225
NO_COLOR = 0
WHITE = 1
BLUE_BEFORE_RED = 2
BLUE_BEFORE_WHITE = 3
RED = 4
COLORS = set([WHITE, BLUE_BEFORE_RED, BLUE_BEFORE_WHITE, RED])

strips_number = int(raw_input())

class Solution(object):
  def __init__(self):
    self.M = [None] * 45*5
    self.M[0] = 0
    self.M[1] = 2      # n=1 last_color=NO_COLOR
    self.M[45+1] = 1   # n=1 last_color=WHITE
    self.M[45*2+1] = 1 # n=1 last_color=BLUE_BEFORE_RED
    self.M[45*3+1] = 1 # n=1 last_color=BLUE_BEFORE_WHITE
    self.M[45*4+1] = 1 # n=1 last_color=RED

  def flags(self, n, last_color=NO_COLOR):
    call_code = n+last_color*45
    if self.M[call_code] is not None:
      return self.M[call_code]
    else:
      count = 0
      if last_color == WHITE:
        count += self.flags(n-1, RED)
        count += self.flags(n-1, BLUE_BEFORE_WHITE)
      elif last_color == RED:
        count += self.flags(n-1, RED)
        count += self.flags(n-1, BLUE_BEFORE_RED)
      elif last_color == BLUE_BEFORE_RED:
        count += self.flags(n-1, WHITE)
      elif last_color == BLUE_BEFORE_WHITE:
        count += self.flags(n-1, RED)
      elif last_color == NO_COLOR:
        count += self.flags(n-1, WHITE)
        count += self.flags(n-1, RED)
      self.M[call_code] = count
      return self.M[call_code]

sol = Solution()
print sol.flags(strips_number)
