#include "foo/public-foo.h"

int main() {
    int a = 5;
    int b = 3;

    int sum = foo::add(a, b);
    //int difference = foo::subtract(a, b); //is private, so this line will cause a compilation error

    return 0;
}
