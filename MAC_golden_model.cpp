#include <cstdint>
#include <stdio.h>

extern "C" {
    //need to hardcode taps or else DPI-C throws a fit
    void golden_model (char taps, 
        short int coeffs[8], 
        short int data[8], 
        int products[8]) {
        for (int i = 0; i < taps; i++) {
            products[i] = (int)(coeffs[i]) * (data[i]);
            printf("%d : %d\n", i, products[i]);
            printf("\n");
        }
    }
}



int main() 
{   
    const char TAPS = 8;

    short int coefficients[TAPS] = {-32768, -5, 12, 216, 14, -5000, 32767, -32768};
    short int data[TAPS] = {-32768, 5043, 16, 0, 0, 3, 32767, 32767};
    int products[TAPS] = {0};

    golden_model(TAPS, coefficients, data, products);

    return 0;
}