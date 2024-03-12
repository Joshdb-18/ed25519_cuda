__global__ void ed25519_test(int i);
__global__ void ed25519_kernel_create_keypair_batch(unsigned char* public_key, unsigned char* private_key, const unsigned char* seed, int limit);
__host__ void ed25519_kernel_create_seed(unsigned char* seed, int batch_size);