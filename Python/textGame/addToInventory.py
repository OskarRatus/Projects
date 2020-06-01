# adding stuff to inventory


def displayInventory(inventory):
    print("Inventory: ")
    item_total = 0
    for k, v in inventory.items():
        item_total += v
        print(str(v) + ' ' + str(k))

    print('Total number of items: ' + str(item_total))


def addToInventory(inventory, addedItems):
    for itm in addedItems:
        inventory.setdefault(itm, 0)
        inventory[itm] += 1
    return(inventory)


inv = {'gold coin': 42, 'rope': 1}
dragonLoot = ['gold coin', 'dagger', 'gold coin', 'gold coin', 'ruby']
inv = addToInventory(inv, dragonLoot)
displayInventory(inv)
