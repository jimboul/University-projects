
def bipartiteMatch(graph):
	'''Find maximum cardinality matching of a bipartite graph (U,V,E).
	The input format is a dictionary mapping members of U to a list
	of their neighbors in V.  The output is a triple (M,A,B) where M is a
	dictionary mapping members of V to their matches in U, A is the part
	of the maximum independent set in U, and B is the part of the MIS in V.
	The same object may occur in both U and V, and is treated as two
	distinct vertices if this happens.'''
	
	# Initialize greedy matching (redundant, but faster than full search)
	matching = {}
	for u in graph:
		for v in graph[u]:
			if v not in matching:
				matching[v] = u
				break
	
	while 1:
		# Structure residual graph into layers
		# unmatched gives a list of unmatched vertices in final layer of V,
		# and is also used as a flag value for pred[u] when u is in the first layer
		previousNeighbour = {}
		unmatched = []
		prevListNeighbours = dict([(u,unmatched) for u in graph])
		for v in matching:
			del prevListNeighbours[matching[v]]
		layer = list(prevListNeighbours)
		
		# Repeatedly extend layering structure by another pair of layers
		while layer and not unmatched:
			newLayer = {}
			for u in layer:
				for v in graph[u]:
					if v not in previousNeighbour:
						newLayer.setdefault(v,[]).append(u)
			layer = []
			for v in newLayer:
				previousNeighbour[v] = newLayer[v]
				if v in matching:
					layer.append(matching[v])
					prevListNeighbours[matching[v]] = v
				else:
					unmatched.append(v)
		
		# Did we finish layering without finding any alternating paths?
		if not unmatched:
			unlayered = {}
			for u in graph:
				for v in graph[u]:
					if v not in previousNeighbour:
						unlayered[v] = None
			return (matching,list(prevListNeighbours),list(unlayered))

		# Recursively search backward through layers to find alternating paths
		# Recursion returns true if found path, false otherwise
		def recurse(v):
			if v in previousNeighbour:
				L = previousNeighbour[v]
				del previousNeighbour[v]
				for u in L:
					if u in prevListNeighbours:
						pu = prevListNeighbours[u]
						del prevListNeighbours[u]
						if pu is unmatched or recurse(pu):
							matching[v] = u
							return 1
			return 0

		for v in unmatched: recurse(v)
