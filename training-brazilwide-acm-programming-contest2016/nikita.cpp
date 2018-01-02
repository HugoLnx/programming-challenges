// https://www.hackerrank.com/challenges/array-splitting
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

#define FOR(it, b, e) for (int it = (b); it <= (e); ++it)
#define FORX(it, b, e) for (int it = (b); it < (e); ++it)
#define TIMES(it, e) for (int it = 0; it < (e); ++it)
#define MSET(c, v) memset(c, v, sizeof(c))
#define P(x...) //printf(x)
const int INF = 0x3F3F3F3F; const int NEGINF = 0xC0C0C0C0;

using namespace std;
int cases, n, t, a[20000], M[20000];

int nikita(int b, int e, int sum) {
	P("%d %d %d\n",b, e, sum);
	if(M[b] >= 0) return M[b];
	int lsum = 0, rsum = sum;
	FORX(i,b,e) {
		lsum += a[i]; rsum -= a[i];
		if(lsum == rsum) {
			int lpoints = nikita(b,i,lsum) + 1;
			int rpoints = nikita(i+1,e,rsum) + 1;
			M[b] = max(lpoints,rpoints);
			break;
		}
	}
	if(M[b] == -1) M[b] = 0;
	return M[b];
}

int main()
{
	cin >> cases;
	TIMES(i,cases) {
		int sum = 0;
		cin >> n;
		TIMES(i,n) {
			cin >> a[i];
			sum += a[i];
		}
		MSET(M,-1);
		printf("%d\n", nikita(0, n-1, sum));
	}

  return 0;
}

