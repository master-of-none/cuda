#include <iostream>

__global__ void vecAddKernel(float *A, float *B, float *C, int n)
{
  int i = threadIdx.x + blockDim.x * blockIdx.x;
  if (i < n)
  {
    C[i] = A[i] * B[i];
  }
}
void vecAdd(float *A_h, float *B_h, float *C_h, int n)
{
  int size = n * sizeof(float);
  float *A_d, *B_d, *C_d;

  // 1. Allocate device memory for A, B and C and Copy A, B to device
  cudaMalloc((void **)&A_d, size);
  cudaMalloc((void **)&B_d, size);
  cudaMalloc((void **)&C_d, size);

  cudaMemcpy(A_d, A_h, size, cudaMemcpyHostToDevice);
  cudaMemcpy(B_d, B_h, size, cudaMemcpyHostToDevice);

  // 2. Call Kernel to launch grid of threads, copy to GPU and compute
  vecAddKernel<<<ceil(n / 256.0), 256>>>(A_d, B_d, C_d, n);
  // 3. Bring back C to device from GPU and free
  cudaMemcpy(C_h, C_d, size, cudaMemcpyDeviceToHost);
  cudaFree(A_d);
  cudaFree(B_d);
  cudaFree(C_d);
}

int main()
{
  int n = 10000;
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