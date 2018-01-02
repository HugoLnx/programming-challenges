// https://leetcode.com/problems/two-sum
#include <map>
#include <vector>

using namespace std;

class Solution {
public:
	vector<int> twoSum(vector<int>& nums, int target) {
		map<int,int> ns;
		vector<int> v(2);

		for(int i = 0; i < nums.size(); i++) {
			ns[nums[i]] = i+1;
		}
		for(int i = 0; i < nums.size(); i++) {
			if(ns[target-nums[i]] && i != ns[target-nums[i]]-1) {
				v[0] = i;
				v[1] = ns[target-nums[i]]-1;
				return v;
			}
		}
		return v;

	}
};

