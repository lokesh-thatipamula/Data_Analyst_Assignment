string = input()

result = ''

for each in string:
    if each not in result:
        result += each

print(result)
