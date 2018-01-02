// https://www.hackerrank.com/challenges/maxsubarray
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <map>
#include <vector>
#include <set>
#include <queue>
#define FORX(I,B,E) for(long long int I = B; I < E; I++)
#define FOR(I,B,E) for(long long int I = B; I <= E; I++)
const int NEGINF = 0xc0c0c0c0;

using namespace std;

int cases, n, a[100005];
int M[100005];

int maxsubarray() {
	int sum = 0;
	int havezero = 0;
	int bigger = NEGINF;
	FORX(i,0,n) {
		if(a[i] == 0) havezero = 1;
		else if(a[i] > 0) sum += a[i];
		if(a[i] > bigger) bigger = a[i];
	}
	if(sum == 0) {
		if(havezero) return 0;
		else return bigger;
	} else return sum;
}

int maxinclusivesubarray(int c) {
	if(M[c] != NEGINF) return M[c];
	if(c >= n) M[c] = NEGINF;
	else {
		int sumnext = maxinclusivesubarray(c+1);
		M[c] = sumnext > 0 ? a[c] + sumnext : a[c];
	}
	return M[c];
}

int maxcontsubarray() {
	int max = NEGINF;
	FOR(i,0,n) {
		int sum = maxinclusivesubarray(i);
		if(sum > max) max = sum;
	}
	return max;
}


int main()
{
	cin >> cases;
	FORX(i,0,cases) {
		memset(M, NEGINF, 100005*sizeof(int));
		cin >> n;
		FORX(j,0,n) {
			cin >> a[j];
		}

		printf("%d %d\n",maxcontsubarray(),maxsubarray());
	}

  return 0;
}

