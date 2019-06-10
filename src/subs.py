def f(s, t):
    for i in range(len(s) - len(t)):
        if t == s[i:i+len(t)]:
            yield i+1

if __name__ == '__main__':
    s = input()
    t = input()
    print(' '.join(str(x) for x in f(s, t)))