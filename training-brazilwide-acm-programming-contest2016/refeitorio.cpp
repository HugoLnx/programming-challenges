#include <stdio.h>
#include <climits>
#include <limits>
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

long double meals[105];
long double a, b;
long long int cases, size;

using namespace std;
long long int gcd(long long int x, long long int y) {
	return y ? gcd(y, x % y) : x;
}

int main()
{
	while(true) {
		cin >> size;
		if(size == 0) break;
		cin >> a;
		cin >> b;

		memset(meals, 0x00, sizeof(long double)*105);
		for(long long int i = 0; i < size; i++) {
			long long int meal;
			cin >> meal;
			meals[meal]++;
		}

		long double minsum = numeric_limits<long double>::max();
		long long int minden, minnum;
		long long int minsden = 1, minsnum = 1;
		long long int cden, cnum;
		for(long long int inum = 1; inum <= 100; inum++) {
			for(long long int iden = 1; iden <= inum; iden++) {
				long double plate = ((long double)inum) / ((long double)iden);
				long double sum = 0;
				long long int snum = 1;
				long long int sden = 1;
				for(long long int meal = 1; meal <= 100; meal++) {
					if(meals[meal] == 0) continue;
					if(ceil(meal/plate) > 3) {
						sum = minsum;
						break;
					}
					long double cost = b*ceil(meal/plate) + max((long double) 0.0,a*(ceil(meal/plate)*plate - meal));
					long long int cnum = b*ceil(meal/plate)*iden;
					long long int waste = a*(ceil(meal/plate)*inum - meal*iden);
					if(waste > 0) cnum += waste;
					long long int cden = iden;

					snum = (sden*cnum + cden*snum)*meals[meal];
					sden = sden*cden;
								if(sden >= 0xffffffff) {
									long long int g = gcd(snum, sden);
									snum = snum / g;
									sden = sden / g;
								}
					sum += cost*meals[meal];
				}
				if(sum < minsum) {
					minsum = sum;
					minnum = inum;
					minden = iden;
					minsnum = snum;
					minsden = sden;
				}
			}
		}
		minsnum -= minsden;
		long long int g = gcd(minsnum, minsden);
		//if(minsnum == 0 || minsden == 0) g = 1;
		minsnum = minsnum / g;
		minsden = minsden / g;

		if(minsden == 1) {
			printf("%llu\n", minsnum);
		} else {
			printf("%llu / %llu\n", minsnum, minsden);
		}
	}
	
  return 0;
}

