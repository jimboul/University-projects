import random;

nucs = ['A','C','G','T']; #all the possible nucleodites
length = random.randint(1,50); #sequence random length 
game = [];

#sequence initialisation
for i in range (1,length):
	current_nuc = random.randint(0,3); #sequence random content
	game.append(nucs[current_nuc]);

print game;
while (game):
	if length%2 == 0 and length > 2:
		playerA_choice = 1;
		game.pop();
		length -= 1;
		print "Player A: " , game;
		playerB_choice = random.randint(1,2);
		if (playerB_choice == 1):
			game.pop();
		else:
			game.pop();
			game.pop();
		length -= playerB_choice;
		print "Player B: " , game;
	elif length%2 == 1 and length > 2:
		playerA_choice = 2;
		game.pop();
		game.pop();
		length -= 2;
		print "Player A: " , game;
		playerB_choice = random.randint(1,2);
		if (playerB_choice == 1):
			game.pop();
		else:
			game.pop();
			game.pop();
		length -= playerB_choice;
		print "Player B: " , game;
	else: 
		try:
			playerA_choice = length;
			if (playerA_choice == 1):
				game.pop();
			else:
				game.pop();
				game.pop();
			length -= playerA_choice;
		except IndexError, e:
			print "The list is empty now.";
		else:
			print "The list is empty now.";
		finally:
			print "Player A: " , game;

print "The game is over! Player A won again!";