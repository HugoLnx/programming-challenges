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
#define P(x...) printf(x)
#define READALL(A,N) TIMES(i,N) { cin >> A[i]; }
using namespace std;
const int INF = 0x3F3F3F3F; const int NEGINF = 0xC0C0C0C0;
int cases, n,a[1000009];
vector<pair<int,pair<int,int> > > s;  // size,(before,largest)


int main()
{
	cin >> n;
	READALL(a,n)
	int smallest = INF;
	int largest = -1;
	TIMES(i,n) {
		P("a[i] = %d\n", a[i]);
		if(a[i] <= smallest) {
			smallest = a[i];
			s.push_back(make_pair(1,make_pair(0,a[i])));
		} else if(a[i] > largest) {
			largest = a[i];
			FORX(j,0,s.size()) {
				if(s[j].first == 0) continue;
				smallest = INF;
				if(a[i] > s[j].second.second) {
					s[j].first++;
					s[j].second.first = s[j].second.second;
					s[j].second.second = a[i];
				}
				smallest = min(smallest, s[j].second.second);
			}
		} else {
			int selected = -1;
			FORX(j,0,s.size()) {
				if(s[j].first == 0) continue;
				if(a[i] > s[j].second.first  && a[i] < s[j].second.second) {
					s[j].second.second = a[i];
					if(selected == -1 || s[j].first > s[selected].first) {
						selected = j;
					}
				}
			}
			FORX(j,0,s.size()) {
				if(s[j].first == 0) continue;
				smallest = INF;
				largest = -1;

				if(j != selected && s[j].second.second == s[selected].second.second) {
					s[j].first = 0;
				}

				smallest = min(smallest, s[j].second.second);
				largest = max(largest, s[j].second.second);
			}
		}
		FORX(j,0,s.size()) {
			P("%d {%d, %d}\n", s[j].first, s[j].second.first, s[j].second.second);
		}
	}
	int m = 0;
	FORX(j,0,s.size()) {
		m = max(m, s[j].first);
	}
	printf("%d\n", m);
  return 0;
}

