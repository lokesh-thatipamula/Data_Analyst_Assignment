string = input()

op = ''

for each in string:
    if each not in op:
        op += each

print(op)
