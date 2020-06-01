# Gra w kółko i krzyżyk

theBoard = [' '] * 10


def printBoard(board):
    print(board['top-L'] + '|' + board['top-M'] + '|' + board['top-R'])
    print('-+-+-')
    print(board['mid-L'] + '|' + board['mid-M'] + '|' + board['mid-R'])
    print('-+-+-')
    print(board['low-L'] + '|' + board['low-M'] + '|' + board['low-R'])


def isWinning(turn):
    # górna linia
    if theBoard[1] == turn and theBoard[2] == turn and theBoard[3] == turn:
        print('Player ' + turn + ' has won!')
        win = True

# środkowa linia
    elif theBoard.get('mid-L', 0) == theBoard.get('mid-M', 0) == theBoard.get('mid-R', 0) == turn:
        print('Player ' + turn + ' has won!')
        win = True

# dolna linia
    elif theBoard.get('low-L', 0) == theBoard.get('low-M', 0) == theBoard.get('low-R', 0) == turn:
        print('Player ' + turn + ' has won!')
        win = True

# pierwszy skos
    elif theBoard.get('top-L', 0) == theBoard.get('mid-M', 0) == theBoard.get('low-R', 0) == turn:
        print('Player ' + turn + ' has won!')
        win = True

# drugi skos
    elif theBoard.get('low-L', 0) == theBoard.get('mid-M', 0) == theBoard.get('top-R', 0) == turn:
        print('Player ' + turn + ' has won!')
        win = True

    else:
        win = False

    return win


turn = 'X'

for i in range(9):
    printBoard(theBoard)
    print('Turn for ' + turn + '. Move on which space?')
    move = input()
    theBoard[move] = turn

    if isWinning(turn):
        break

    if turn == 'X':
        turn = 'O'
    else:
        turn = 'X'

# printBoard(theBoard)
