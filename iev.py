def f(a1, a2, a3, a4, a5, a6):
    return (a1*2 + a2*2 + a3*2 + 3/4*a4*2 + 1/2*a5*2 + 0)

if __name__ == '__main__':
    print(f(*map(int, input().split(' '))))