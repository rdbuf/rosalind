def f(k, m, n):
    s = k + m + n
    matches = k * ((k-1)/2 + m + n) + m * (m-1) / 2 * 3/4 + m * n * 2/4
    return matches / (s * (s-1) / 2)

if __name__ == '__main__':
    k, m, n = map(int, input().split(' '))
    print(f(k, m, n))