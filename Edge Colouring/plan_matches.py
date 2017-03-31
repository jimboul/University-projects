
from bipartite import bipartiteMatch
import sys

# Get the max degree of the graph which is necessary in order to know the number of distinct colours
def max_degree(graph):
	maxDegree_u = max(len(v) for v in graph.values() )
	count={}
	for vlist in graph.values():
		for v in vlist:
			try:
				count[v]+=1
			except KeyError:
				count[v]=1
	maxDegree_v=max(count.values())
	return max(maxDegree_v,maxDegree_u)

# Find the best match for our bipartite graph and put the necessary information into a dictionary
def best_match(graph):
	bestMatch = bipartiteMatch(graph)[0]
	return dict((value,key) for (key,value) in bestMatch.items())

# Apply the graph algorithm for solving the edge-colouring problem
def edge_coloring(graph):
	gr = graph.copy()
	fileWriter = 'example_graph_solutions.txt' 
	streamWriter = open(fileWriter, 'w')
	numberOfColors = max_degree(gr)
	
	for color in range(numberOfColors):
		print 'Day #' + str(color)
		bestMatching = best_match(gr)
		print bestMatching
		for i in range(0,len(bestMatching.items())):
			streamWriter.write(str(bestMatching.items()[i]) + " " + str(color) + '\n')
			print str(bestMatching.items()[i]) + " " + str(color) + '\n'
		
		
		for k in gr.copy():
			try:
				gr[k].remove(bestMatching[k])
			except KeyError:
				pass
				
	streamWriter.close()	
	
def main():
	# Read the input file get the data save them into a string and manipulate them so that each pair of players (and only one) be at each line
	# Finally we sort these data for ease of use
	fileReader = 'example_graph_3.txt' # using sys.argv[1] we take the first argument after the program name (sys.argv[0]) from the command prompt and we consider itthe input file. Instead, we can use the following local path 'example_graph_3.txt' for a "fixed" solution
	inputFile = open(fileReader, 'r')
	raw_data = inputFile.read()
	data = raw_data.splitlines()
	singleLine = [data[i:i+1] for i in xrange(0, len(data))]	
	singleLine.sort()
	# Print the data sorted
	for line in range(0,len(data)):
		print singleLine[line]
	inputFile.close()
	
	# Write the data down to a temporary but useful .txt file
	outputFile = open('temp.txt', 'w')
	for line in range(0,len(data)):
		outputFile.write(str(singleLine[line][0]) + '\n')
	outputFile.close()
	
	# Read the data from the temporary file and extract the graph data through a data manipulation process
	newInputFile = open('temp.txt', 'r')
	raw_graph_data = newInputFile.read()
	graph_data = raw_graph_data.splitlines()
	textList = list(raw_graph_data)
	
	# Access through the data structure in order to get each node and its neighbours
	graph = {}
	# Open the right files where all the necessary information is going to be saved
	outputFile = open('players.txt', 'w')
	outputFile2 = open('opponents.txt', 'w')
	
	home = textList[0] # Initialize the first node outside the for-loop
	outputFile.write(home + " ") # Simultaneuously we save into the above-mentioned file our data
	away = []
	away.extend(textList[2]) # Initialize the first neighbour of the first node
	enemies = []
	counter = 0
	# Through the iteration below, we find for each node(player) its neughbours(opponents)
	# We start from and we use a step size equal to 4 because this is the appropriate way to access all nodes according to the structure of the textFile list.
	# After 4 steps from a node we can find the next one (checking whether it is the same or not) and after 2 steps we can find one of its neighbour
	for i in range(4,len(textList),4):
		if textList[i] == textList[i-4]:
			away.append(textList[i+2])
			counter += 1
		else:
			outputFile2.write(str(away) + '\n')
			enemies.extend(away)
			enemies[i-counter:i] = [''.join(enemies[i-counter:i])]
			home = textList[i]
			outputFile.write(home + " ") # Simultaneuously we save our data into the players.txt file
			away[:] = [] 
			away.append(textList[i+2])
	
	# Find the opponents and save them in a list named "final_enemies"						
	outputFile2.write(str(away) + '\n')
	enemies.extend(away)
	final_enemies = []
	pos = 0
	for i in range(0,len(enemies)):
		if enemies[i] == '':
			final_enemies.append(enemies[pos:i])
			pos = i + 1
	final_enemies.append(enemies[pos:len(enemies)])		
	print final_enemies, " Away players!"
			
	#temp_graph = {home:away}
	#print temp_graph, " temp_graph"
	#graph.update(temp_graph)
	outputFile.close()
	outputFile2.close()	
	
	# Find the players and save them in a list called "players"
	playersInput = open('players.txt','r')
	raw_players = playersInput.read()
	players = raw_players.split()
	print players, " Home players!"
	
	# Map each node(player) to its neighbours(opponents)
	for i in range(0,len(players)):
		graph[players[i]] = final_enemies[i]
	
	newInputFile.close()
	
	# Now we have our graph as a dictionary in the appropriate format
	print graph
	
	# Apply the edge-colouring algorithm
	edge_coloring(graph)
	
if __name__ == "__main__":
	main()
