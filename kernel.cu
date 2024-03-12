/********************************************************************************/
// https://github.com/Allespro/ed25519_cuda
// test https://cyphr.me/ed25519_tool/ed.html
// PVK TEST: 3DBDF9B1912C999F1CD8289EDE88AAF4B930CD7EB41949A077F9F39B13935B05
// PUB TEST: F908FE4E03875446D863E059B7E95A087F8B3BE4FC9CACFBA9D05AE6B7A6F9FC
/********************************************************************************/



#include <cuda.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdint.h>
#include <stdio.h>
#include "ge.cuh"
#include "sc.cuh"
#include "kernel.cuh"

//unsigned int PERF_BLOCKS = 1024;
//unsigned int PERF_THREADS = 256;

//include "ed25519.cuh"

//include "onion.cuh"


__global__ void ed25519_test(int i) {
	i = 0;
	ge_p3 A;
	//***pva ed25519 test
	unsigned char public_key[32];
	//unsigned char private_key[64] = { 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 };
	unsigned char private_key[64] = { 0x3d, 0xbd, 0xf9, 0xb1, 0x91, 0x2c, 0x99, 0x9f, 0x1c, 0xd8, 0x28, 0x9e, 0xde, 0x88, 0xaa, 0xf4, 0xb9, 0x30, 0xcd, 0x7e, 0xb4, 0x19, 0x49, 0xa0, 0x77, 0xf9, 0xf3, 
		0x9b, 0x13, 0x93, 0x5b, 0x05 };
	//unsigned char private_key[64] = "01234567890123456789012345678901";
	//unsigned char private_key[64] = {0};
	//printf("\n ED25519 TEST\n");
	printf("PVK TEST: 3dbdf9b1912c999f1cd8289ede88aaf4b930cd7eb41949a077f9f39b13935b05\n");

	printf("PVK ORIG: %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
		private_key[0], private_key[1], private_key[2], private_key[3], private_key[4], private_key[5], private_key[6], private_key[7],
		private_key[8], private_key[9], private_key[10], private_key[11], private_key[12], private_key[13], private_key[14], private_key[15],
		private_key[16], private_key[17], private_key[18], private_key[19], private_key[20], private_key[21], private_key[22], private_key[23],
		private_key[24], private_key[25], private_key[26], private_key[27], private_key[28], private_key[29], private_key[30], private_key[31]);

	private_key[0] &= 248;
	private_key[31] &= 63;
	private_key[31] |= 64;

	printf("PVK Clamping: %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
		private_key[0], private_key[1], private_key[2], private_key[3], private_key[4], private_key[5], private_key[6], private_key[7],
		private_key[8], private_key[9], private_key[10], private_key[11], private_key[12], private_key[13], private_key[14], private_key[15],
		private_key[16], private_key[17], private_key[18], private_key[19], private_key[20], private_key[21], private_key[22], private_key[23],
		private_key[24], private_key[25], private_key[26], private_key[27], private_key[28], private_key[29], private_key[30], private_key[31]);

	ge_scalarmult_base(&A, private_key);
	ge_p3_tobytes(public_key, &A);

	printf("PUB ED: %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
		public_key[0], public_key[1], public_key[2], public_key[3], public_key[4], public_key[5], public_key[6], public_key[7],
		public_key[8], public_key[9], public_key[10], public_key[11], public_key[12], public_key[13], public_key[14], public_key[15],
		public_key[16], public_key[17], public_key[18], public_key[19], public_key[20], public_key[21], public_key[22], public_key[23],
		public_key[24], public_key[25], public_key[26], public_key[27], public_key[28], public_key[29], public_key[30], public_key[31]);

	//printf("Correct D04AB232742BB4AB3A1368BD4615E4E6D0224AB71A016BAF8520A332C9778737");
	printf("Correct F908FE4E03875446D863E059B7E95A087F8B3BE4FC9CACFBA9D05AE6B7A6F9FC\n");
}
//*** ed25519 TEST

int main(int argc, char **argv) {

	ed25519_test << <1, 1>> > (1);
    	
	return 0;
}
