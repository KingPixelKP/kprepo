#include "public-foo.h"

int main() {
    int a = 5;
    int b = 3;

    int sum = foo::add(a, b);
    int difference = foo::subtract(a, b);

    return 0;
}