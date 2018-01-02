// https://www.urionlinejudge.com.br/judge/en/problems/view/1715
#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;

int main()
{
	int p, m;
	while(scanf("%d %d",&p, &m) != EOF) {
		int players = 0;
		int i;
		for(i = 0; i < p; i++)
		{
			int scoredInAll = 1;
			int j;
			for(j = 0; j < m; j++)
			{
				int score;
				cin >> score;
				if(score == 0) scoredInAll = 0;
			}
			if(scoredInAll) players++;
		}
		cout << players << endl;
  }
  return 0;
}

