// https://www.urionlinejudge.com.br/judge/en/problems/view/1708
#include <iostream>
#include <stdio.h>
#include <math.h>
 
using namespace std;

int main()
{
	double x, y;
	cin >> x;
	cin >> y;
	printf("%d\n", (int) ceil(y/(y-x)));
  return 0;
}

