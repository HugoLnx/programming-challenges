// http://acm.timus.ru/problem.aspx?space=1&num=1119
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <math.h>

using namespace std;

int width, height, qnt_diagonals;
double M[1001*1001];
char dig_to[1001*1001];

double short_distance(int x, int y) {
  if(x == 0 && y == 0) {
    return 0.0;
  } else if(!M[x+y*1001]) {
    double dist;
    double smaller = 1000*1000;
    if(x >= 1) {
      dist = short_distance(x-1, y) + 100;
      if(dist < smaller) smaller = dist;
    }

    if(y >= 1) {
      dist = short_distance(x, y-1) + 100;
      if(dist < smaller) smaller = dist;
    }

    if(dig_to[x+y*1001]) {
      dist = short_distance(x-1, y-1) + 141.421356;
      if(dist < smaller) smaller = dist;
    }
    M[x+y*1001] = smaller;
  }
  return M[x+y*1001];
}

int main()
{
  memset(M, 0x00, 1001*1001);
  memset(dig_to, 0x00, 1001*1001);

  scanf("%d %d", &width, &height);
  scanf("%d", &qnt_diagonals);

  for(int i = 0; i < qnt_diagonals; i++) {
    int x, y;
    scanf("%d %d", &x, &y);
    dig_to[x+y*1001] = 1;
  }

  printf("%d\n", (int) round(short_distance(width, height)));

  return 0;
}

