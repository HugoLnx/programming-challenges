// https://www.urionlinejudge.com.br/judge/en/problems/view/1709
#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;

int main()
{
	int c;
	while(scanf("%d",&c) != EOF) {
		int count = 1;
		int ci = 2;
		while(ci != 1) {
			if(ci <= c/2) ci = 2*ci;
			else ci = c - (2*(c-ci) + 1);
			count++;
		}
		cout << count << endl;
  }
  return 0;
}

