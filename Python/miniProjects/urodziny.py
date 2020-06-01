birthdays = {'Alice': 'Apr 1', 'Bob': 'Dec 12', 'Carol': 'Mar 4'}

while True:
    print('Enter a name: (blank to quit)')
    name = input()
    if name == '':
        break
    elif name in birthdays:
        print(birthdays[name] + ' is the birthday of ' + name)

    else:
        print('I do not have ' + name + ' in memory')
        print('Type date of ' + name + ' birthday')
        bday = input()
        birthdays[name] = bday
        print('Database has been updated.')
