#include "private-foo.h"
#include "public-foo.h"

namespace foo {
    int add(int a, int b) {
        return a + b;
    }

    int subtract(int a, int b) {
        return a - b;
    }
}