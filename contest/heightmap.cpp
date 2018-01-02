// Height Map
// ACM Brazilian final: http://maratona.ime.usp.br/resultados15/contest_onesided.pdf
// Question H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>

using namespace std;
int matrix[110][110];
int rows, cols;
int visited[110][110];

int isToAddNewFaceOf(int i, int j) {
	if(visited[i][j]) return 0;
	visited[i][j] = 1;
	if(i+1 < rows && matrix[i][j] == matrix[i+1][j])
		isToAddNewFaceOf(i+1, j);

	if(i-1 >= 0   && matrix[i][j] == matrix[i-1][j])
		isToAddNewFaceOf(i-1, j);

	if(j+1 < cols && matrix[i][j] == matrix[i][j+1])
		isToAddNewFaceOf(i, j+1);

	if(j-1 <= 0   && matrix[i][j] == matrix[i][j-1])
		isToAddNewFaceOf(i, j-1);
	return 1;
}

int calculateTopFaces() {
	memset(visited, 0x00, sizeof(int)*110*110);
	int faces = 0;
	for(int i = 0; i < rows; i++) {
		for(int j = 0; j < cols; j++) {
			if(isToAddNewFaceOf(i,j)) {
				faces++;
			}
		}
	}
	return faces;
}

int haveIntersection(int targetSize1, int afterSize1, int targetSize2, int afterSize2) {
	if(targetSize1-afterSize1 == 0 || targetSize2-afterSize2 == 0) return 0;

	if(afterSize1 >= targetSize2 || targetSize1 <= afterSize2) {
		return 0;
	} else {
		return 1;
	}
}

int calculateEastFaces() {
	memset(visited, 0x00, sizeof(int)*110*110);
	int faces = 1;
	for(int i = 0; i < rows; i++) {
		for(int j = 0; j < cols-1; j++) {
			if(visited[i][j] != 1) {
				visited[i][j] = 1;
				int diff = matrix[i][j] - matrix[i][j+1];
				if(diff > 0) {
					faces++;

					// Mark cols up as visited
					int lastTarget = matrix[i][j];
					int lastAfter  = matrix[i][j+1];
					for(int ii = i-1; ii >= 0; ii--) {
						if(haveIntersection(lastTarget, lastAfter, matrix[ii][j], matrix[ii][j+1])) {
							visited[ii][j] = 1;
							lastTarget = matrix[ii][j];
							lastAfter = matrix[ii][j+1];
						} else {
							break;
						}
					}

					// Mark cols down as visited
					lastTarget = matrix[i][j];
					lastAfter  = matrix[i][j+1];
					for(int ii = i+1; ii < rows; ii++) {
						if(haveIntersection(lastTarget, lastAfter, matrix[ii][j], matrix[ii][j+1])) {
							visited[ii][j] = 1;
							lastTarget = matrix[ii][j];
							lastAfter = matrix[ii][j+1];
						} else {
							break;
						}
					}
				}
			}
		}
	}
	return faces;
}


int calculateWestFaces() {
	memset(visited, 0x00, sizeof(int)*110*110);
	int faces = 1;
	for(int i = 0; i < rows; i++) {
		for(int j = cols-1; j > 0; j--) {
			if(visited[i][j] != 1) {
				visited[i][j] = 1;
				int diff = matrix[i][j] - matrix[i][j-1];
				if(diff > 0) {
					faces++;

					// Mark cols up as visited
					int lastTarget = matrix[i][j];
					int lastAfter  = matrix[i][j-1];
					for(int ii = i-1; ii >= 0; ii--) {
						if(haveIntersection(lastTarget, lastAfter, matrix[ii][j], matrix[ii][j-1])) {
							visited[ii][j] = 1;
							lastTarget = matrix[ii][j];
							lastAfter = matrix[ii][j-1];
						} else {
							break;
						}
					}

					// Mark cols down as visited
					lastTarget = matrix[i][j];
					lastAfter  = matrix[i][j-1];
					for(int ii = i+1; ii < rows; ii++) {
						if(haveIntersection(lastTarget, lastAfter, matrix[ii][j], matrix[ii][j-1])) {
							visited[ii][j] = 1;
							lastTarget = matrix[ii][j];
							lastAfter = matrix[ii][j-1];
						} else {
							break;
						}
					}
				}
			}
		}
	}
	return faces;
}


int calculateNorthFaces() {
	memset(visited, 0x00, sizeof(int)*110*110);
	int faces = 1;
	for(int j = 0; j < cols; j++) {
		for(int i = rows-1; i > 0; i--) {
			if(visited[i][j] != 1) {
				visited[i][j] = 1;
				int diff = matrix[i][j] - matrix[i-1][j];
				if(diff > 0) {
					faces++;

					// Mark cols up as visited
					int lastTarget = matrix[i][j];
					int lastAfter  = matrix[i-1][j];
					for(int jj = j-1; jj >= 0; jj--) {
						if(haveIntersection(lastTarget, lastAfter, matrix[i][jj], matrix[i-1][jj])) {
							visited[i][jj] = 1;
							lastTarget = matrix[i][jj];
							lastAfter = matrix[i-1][jj];
						} else {
							break;
						}
					}

					// Mark cols down as visited
					lastTarget = matrix[i][j];
					lastAfter  = matrix[i-1][j];
					for(int jj = j+1; jj < cols; jj++) {
						if(haveIntersection(lastTarget, lastAfter, matrix[i][jj], matrix[i-1][jj])) {
							visited[i][jj] = 1;
							lastTarget = matrix[i][jj];
							lastAfter = matrix[i-1][jj];
						} else {
							break;
						}
					}
				}
			}
		}
	}
	return faces;
}


int calculateSouthFaces() {
	memset(visited, 0x00, sizeof(int)*110*110);
	int faces = 1;
	for(int j = 0; j < cols; j++) {
		for(int i = 0; i < rows-1; i++) {
			if(visited[i][j] != 1) {
				visited[i][j] = 1;
				int diff = matrix[i][j] - matrix[i+1][j];
				if(diff > 0) {
					faces++;

					// Mark cols up as visited
					int lastTarget = matrix[i][j];
					int lastAfter  = matrix[i+1][j];
					for(int jj = j-1; jj >= 0; jj--) {
						if(haveIntersection(lastTarget, lastAfter, matrix[i][jj], matrix[i+1][jj])) {
							visited[i][jj] = 1;
							lastTarget = matrix[i][jj];
							lastAfter = matrix[i+1][jj];
						} else {
							break;
						}
					}

					// Mark cols down as visited
					lastTarget = matrix[i][j];
					lastAfter  = matrix[i+1][j];
					for(int jj = j+1; jj < cols; jj++) {
						if(haveIntersection(lastTarget, lastAfter, matrix[i][jj], matrix[i+1][jj])) {
							visited[i][jj] = 1;
							lastTarget = matrix[i][jj];
							lastAfter = matrix[i+1][jj];
						} else {
							break;
						}
					}
				}
			}
		}
	}
	return faces;
}

int main()
{
	while(scanf("%d %d", &rows, &cols) != EOF) {
		memset(matrix, 0x00, sizeof(int)*110*110);
		for(int i = 0; i < rows; i++) {
			for(int j = 0; j < cols; j++) {
				scanf("%d", &matrix[i][j]);
			}
		}

		int faces = calculateTopFaces()+ calculateEastFaces()+ calculateWestFaces()+ calculateNorthFaces()+ calculateSouthFaces()+1;
		//printf("%d\n", faces);
		printf("%d %d %d %d %d %d\n", calculateTopFaces(), calculateEastFaces(), calculateWestFaces(), calculateNorthFaces(), calculateSouthFaces(), faces);
	}
  return 0;
}

