#include <iostream>

void vecAdd(float *A_h, float *B_h, float *C_h, int n)
{
  for (int i = 0; i < n; i++)
  {
    C_h[i] = A_h[i] * B_h[i];
  }
}

int main()
{
  int n = 10;
  float A[n], B[n], C[n];

  for (int i = 0; i < n; i++)
  {
    A[i] = rand() % 100;
    B[i] = rand() % 100;
  }
  vecAdd(A, B, C, n);

  for (int i = 0; i < n; i++)
  {
    std::cout << C[i] << " ";
  }
  std::cout << std::endl;
}