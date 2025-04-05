int foo(int base, int exp, int i, int result) {
    while (i < exp) {
        result = result * base;
        i = i + 1;
    }
}