#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <iostream>
#include <assert.h>
#include <algorithm>
#include <sstream>
#include <cstring>
#include <limits>

using namespace std;

class TSP

{
	public:
		TSP(const double crossoverProbability, const double mutationProbability);

		//The constants used in this project 
		static const unsigned int chromosomes = 30, cities = 5, xMin = 0, xMax = 1000, yMin = 0, yMax = 500;

		// Generate a random population of chromosome 
		inline void randomPopulation();

		// Create a new population using crossover and mutation 
		inline void getNewPopulation();

		// Returns the fitness of the best chromosome
		inline double getBestFitness() const;

		// Returns a string representation of the best path 
		inline string getBestPathString() const;

		// Returns the total distance of the best chromosome path
		inline double getLowestTotalDistance() const;

		// Returns the populations average length
		inline double getAverageDistance() const;
	private:
		const double crossoverProbability, mutationProbability;

		//Gets the total distance of the supplied path
		//double TSP::totalDistance(int const * const chromosome) const;
		inline double totalDistance(int const * const chromosome) const;

		// The coordinates for each city, (x,y) for the first city is found in (citiesX[0], citiesY[0]) 
	    double citiesX[cities], citiesY[cities];

		// The chromosome containing the shortest path 
		int *bestChromosome;

		//Contains the current population of chromosomes 
		int (* solutions)[cities],
			// The two chromosomes with the best fitness functions
			
			// Used to store the new chromosomes when creating a new population 
			(* newPopulation)[cities];

		// Returns a random double r, 0 <= r <= max
		inline static double randomInclusive(const double max);

		// Returns a random double r, 0 <= r < max 
		inline static double randomExclusive(const double max);

		// True if the two chromosomes represent the same path 
		inline static bool areChromosomesEqual(int const * const chromosomeA, int const * const chromosomeB);

		// Evaluate the fitness the supplied chromosome
		inline double evaluateFitness(const int * const chromosome) const;

		//Selects a chromosome from the current population using Roulette Wheel Selection, using the algorithm described in http://www.obitko.com/tutorials/genetic-algorithms/selection.php.
		inline int * rouletteSelection(double const * const fitness) const;

		// Replace the element at offspringIndex with the first element found in other that does not exist in offspringToRepair 
		inline void repairOffspring(int * const offspringToRepair, int missingIndex, const int * const other);

		// Might swap one gene with another, depending on the mutation probability (Fisher-Yates shuffle)
		inline void mutate(int * const chromosome);
 
		//Cross over the parents to form new offspring, using multi-point crossover
		//The chromosomes might be a copy of their parents, depending on the crossover probability.
		inline void crossover(const int * const parentA, const int * const parentB, int * const offspringA, int * const offspringB);

		// Checks if the supplied chromosome is in newPopulation 
		inline bool hasDuplicate(const int * const chromosome, size_t populationCount);

		// Copies the supplied chromosome to the new population 
		inline void copyToNewPopulation(const int * const chromosome, size_t index);

		// Make the chromosome represent a path chosen randomly 
		inline static void setRandomPath(int * const chromosome);
};

TSP::TSP(double crossoverProbability, double mutationProbability) : crossoverProbability(crossoverProbability),
	mutationProbability(mutationProbability), solutions(new int[chromosomes][cities]), newPopulation(new int[chromosomes][cities])
{
	// Seed the random number generator
	srand((unsigned int)time(NULL));
	
	// Set random coordinates 
	for(size_t coordinateIndex = 0; coordinateIndex < cities; ++coordinateIndex)
	{
		citiesX[coordinateIndex] = randomInclusive(xMax);
		citiesY[coordinateIndex] = randomInclusive(yMax);
	}

	randomPopulation();
}

inline void TSP::randomPopulation()
{
	for(size_t chromosomeIndex = 0; chromosomeIndex < chromosomes; ++chromosomeIndex)
	{
		setRandomPath(solutions[chromosomeIndex]);
	}
}

inline double TSP::getBestFitness() const
{
	return evaluateFitness(bestChromosome);
}

inline double TSP::getAverageDistance() const
{
	double distance = 0;
	for(size_t chromosomeIndex = 0; chromosomeIndex < chromosomes; ++chromosomeIndex)
	{
		distance += totalDistance(solutions[chromosomeIndex]);
	}
	return distance/chromosomes;
}

inline string TSP::getBestPathString() const
{
	stringstream path;
	for(size_t gene = 0; gene < cities; ++gene)
	{
		if(gene != 0)
		{
			path << ",";
		}
		path << bestChromosome[gene] + 1;
	}
	return path.str();
}

inline double TSP::getLowestTotalDistance() const
{
	return totalDistance(bestChromosome);
}

inline void TSP::getNewPopulation()
{
	double fitness[chromosomes];

	// Fill an array with a fitness score for each chromosome, the index of a score corresponds with the chromosome's index in solutions[index]
	for(size_t chromosomeIndex = 0; chromosomeIndex < chromosomes; ++chromosomeIndex)
	{
		fitness[chromosomeIndex] = evaluateFitness(solutions[chromosomeIndex]);
	}

	// Use elitism, find and copy over the two best chromosomes to the new population 
	int eliteIndex1 = 0, eliteIndex2 = 0;
	// Find the best solution 
	eliteIndex1 = max_element(fitness, fitness + chromosomes) - fitness;
	this->bestChromosome = solutions[eliteIndex1];

	double highestFitness = 0;
	// Find the second best solution 
	for(size_t chromosomeIndex = 0; chromosomeIndex < chromosomes; ++chromosomeIndex)
	{
		if(chromosomeIndex != eliteIndex1 && fitness[chromosomeIndex] > highestFitness)
		{
			highestFitness = fitness[chromosomeIndex];
			eliteIndex2 = chromosomeIndex;
		}
	}

	// Keep track of how many chromosomes exists in the new population 
	size_t offspringCount = 0;
	// Copy over the two best solutions to the new population 
	copyToNewPopulation(solutions[eliteIndex1], offspringCount);
	++offspringCount;
	copyToNewPopulation(solutions[eliteIndex2], offspringCount);
	++offspringCount;

	// Create the rest of the new population 
	while(true)
	{
		int * parentA;
		int * parentB;
		parentA = rouletteSelection(fitness);
		parentB = rouletteSelection(fitness);
		while (parentB == parentA)
		{
			parentB = rouletteSelection(fitness);
		}
		int offspringA[cities];
		int offspringB[cities];
		crossover(parentA, parentB, offspringA, offspringB);
		mutate(offspringA);
		mutate(offspringB);

		// Add to new population if an equal chromosome doesn't exist already
		if(!hasDuplicate(offspringA, offspringCount))
		{
			copyToNewPopulation(offspringA, offspringCount);
			++offspringCount;
		}
		// We need to check if the new population is filled 
		if(offspringCount == chromosomes)
		{
			break; // break this loop when the new population is complete
		}
		if(!hasDuplicate(offspringB, offspringCount))
		{
			copyToNewPopulation(offspringB, offspringCount);
			++offspringCount;
		}
		// Check again so that we don't accidentally write all over the heap making it corrupted
		if(offspringCount == chromosomes)
		{
			break; //break this loop when the new population is complete
		}
	}

	// We now have a new population, now it needs to replace the current population
	// so that we don't go through the same population every time we run this function
	for(size_t chromosomeIndex = 0; chromosomeIndex < chromosomes; ++chromosomeIndex)
	{
		memcpy(solutions[chromosomeIndex], newPopulation[chromosomeIndex], sizeof(int) * cities);
	}
}

inline bool TSP::hasDuplicate(const int * const chromosome, size_t populationCount)
{
	for(size_t chromosomeIndex = 0; chromosomeIndex < populationCount; ++chromosomeIndex)
	{
		// Compare gene by gene for each chromosome in newPopulation
		int compared_genes = 0;
		for(size_t gene = 0; gene < cities; ++gene)
		{
			if(chromosome[gene] != newPopulation[chromosomeIndex][gene])
			{
				break;
			}
			++compared_genes;
		}

		if(compared_genes == cities)
		{
			return true;
		}
	}

	return false;
}

inline void TSP::mutate(int * const chromosome)
{
	{
		double random = randomInclusive(1);
		// In case no mutation happened
		if(random > mutationProbability)
		{
			return;
		}
	}

	int temp;
	int random1 = (int)randomExclusive(cities);
	int random2 = (int)randomExclusive(cities);
	while(random1 == random2)
	{
		random2 = (int)randomExclusive(cities);
	}

	// Here we are doing the swap mutation
	temp = chromosome[random1];
	chromosome[random1] = chromosome[random2];
	chromosome[random2] = temp;

}

inline void TSP::crossover(int const * const parentA, const int * const parentB, int * offspringA, int * offspringB)
{
	{
		double random = randomInclusive(1);
		// The offspring is a copy of their parents, so we don't perform a crossover
		if(random > crossoverProbability)
		{
			memcpy(offspringA, parentA, sizeof(int) * cities);
			memcpy(offspringB, parentB, sizeof(int) * cities);
			return;
		}
	}
	// Perform multi-point crossover to generate offspring 
	// 0 <= cuttOffIndex <= cities 
	int cuttOffIndex1 = (int)randomInclusive(cities);
	int cuttOffIndex2 = (int)randomInclusive(cities);
	while(cuttOffIndex2 == cuttOffIndex1)
	{
		cuttOffIndex2 = (int)randomExclusive(cities);
	}

	unsigned int start;
	unsigned int end;
	if(cuttOffIndex1 < cuttOffIndex2)
	{
		start = cuttOffIndex1;
		end = cuttOffIndex2;
	}
	else
	{
		start = cuttOffIndex2;
		end = cuttOffIndex1;
	}
	// Offspring A is initially copy of parent A
	memcpy(offspringA, parentA, sizeof(int) * cities);
	// Offspring B is initially copy of parent B 
	memcpy(offspringB, parentB, sizeof(int) * cities);

	// Put a sequence of parent B in offspring A
	memcpy(offspringA + start, parentB + start, sizeof(int) * (end - start));
	// Put a sequence of parent A in offspring B
	memcpy(offspringB + start, parentA + start, sizeof(int) * (end - start));

	// Mark collisions in offspring with -1
	for(size_t cityIndex = 0; cityIndex  < cities; ++cityIndex)
	{
		/* Index is part of the parent sequence */
		if(!(cityIndex  >= start && cityIndex  < end))
		{
			// Check if the item at cityIndex also occurs somewhere in the copied substring
			for(size_t substringIndex = start; substringIndex < end; ++substringIndex)
			{
				// Here we have got a duplicate, so we mark it
				if(offspringA[cityIndex] == offspringA[substringIndex])
				{
					offspringA[cityIndex] = -1;
				}
				if(offspringB[cityIndex] == offspringB[substringIndex])
				{
					offspringB[cityIndex] = -1;
				}
			}
		}

	}

	// Go through the offspring; in case an element is marked we fill the hole with an element from the other offspring
	for(size_t offspringIndex = 0; offspringIndex < cities; ++offspringIndex)
	{
		// There is a hole here
		if(offspringA[offspringIndex] == -1)
		{
			repairOffspring(offspringA, offspringIndex, offspringB);
		}
		if(offspringB[offspringIndex] == -1)
		{
			repairOffspring(offspringB, offspringIndex, offspringA);
		}
	}
}

inline void TSP::repairOffspring(int * const offspringToRepair, int missingIndex, const int * const other)
{
	// Iterate through the other offspring until we find an element which doesn't exist in the offspring we are repairing
	for(size_t patchIndex = 0; patchIndex < cities; ++patchIndex)
	{
		// Look for other[patchIndex] in offspringToRepair
		int *missing = find(offspringToRepair, offspringToRepair + cities, other[patchIndex]);

		// The element at other[patchIndex] is missing from offspringToRepair
		if(missing == (offspringToRepair + cities))
		{
			offspringToRepair[missingIndex] = other[patchIndex];
			break;
		}
	}
}

inline void TSP::copyToNewPopulation(int const * const chromosome, size_t index)
{
	assert(index < chromosomes && "Index out of bounds");
	for(size_t i = 0; i < cities; ++i)
	{
		newPopulation[index][i] = chromosome[i];
	}

}

inline int * TSP::rouletteSelection(double const * const fitness) const
{
	double sum = 0;
	for(size_t i = 0; i < chromosomes; ++i)
	{
		sum += fitness[i];
	}
	double random = randomInclusive(sum);

	sum = 0;
	for(size_t i = 0; i < chromosomes; ++i)
	{
		sum += fitness[i];
		if(sum >= random)
		{
			return solutions[i];
		}
	}
	assert(false && "A chromosome should have been picked by now");
	return(NULL);
}

inline void TSP::setRandomPath(int * chromosome)
{
	for(size_t i = 0; i < cities; ++i)
	{
		chromosome[i] = i;
	}

	//Shuffle the chromosome using the Fisher–Yates shuffle.
	for(size_t i = cities-1; i > 0; --i)
	{
		int random = (int)randomInclusive(i);
		int temp = chromosome[i];
		chromosome[i] = chromosome[random];
		chromosome[random] = temp;
	}
}

inline double TSP::evaluateFitness(int const * const chromosome) const
{
	return 1/totalDistance(chromosome);
}

inline double TSP::totalDistance(int const * const chromosome) const
{
	double distance = 0;
	// Calculate the total distance between all cities
	for(size_t i = 0; i < cities-1; ++i)
	{
		double dx = citiesX[chromosome[i]] - citiesX[chromosome[i+1]];
		double dy = citiesY[chromosome[i]] - citiesY[chromosome[i+1]];

		// The distance between two points
		distance += sqrt((pow(dx, 2.0) + pow(dy, 2.0)));
	}
	// We complete this procedure by adding the distance between the last and the first city
	double dx = citiesX[chromosome[cities-1]] - citiesX[chromosome[0]];
	double dy = citiesY[chromosome[cities-1]] - citiesY[chromosome[0]];

	distance += sqrt((pow(dx, 2.0) + pow(dy, 2.0)));

	return distance;
}

inline double TSP::randomInclusive(double max)
{
	return ((double)rand() * max) / (double)RAND_MAX;
}

inline double TSP::randomExclusive(double max)
{
	return ((double)rand() * max) / ((double)RAND_MAX + 1);
}


int main(int argc, const char *argv[])
{
	// 50% crossover probability, 10% mutation probability
	TSP *tsp = new TSP(0.5, 0.1);
	size_t generations = 0;
	size_t generationsWithoutImprovement = 0;
	double bestFitness = -1;
	double initialAverageDist = tsp->getAverageDistance();

	// We will stop when we've gone 1000 generations without improvement
	while(generationsWithoutImprovement < 1000)
	{
		tsp->getNewPopulation();
		++generations;
		double newFitness = tsp->getBestFitness();
		if(newFitness > bestFitness)
		{
			bestFitness = newFitness;
			generationsWithoutImprovement = 0;
			cout << "Best goal function: " << tsp->getBestFitness() << endl;
		}
		else
		{
			++generationsWithoutImprovement;
		}
	}

	cout << "The procedure is completed!" << endl;
	cout << "Number of generations: " << generations << endl;
	cout << "Best chromosome: " << endl;
	cout << "\t-Path: " << tsp->getBestPathString() << endl;
	cout << "\t-Goal function: " << tsp->getBestFitness() << endl;
	cout << "\t-Distance: " << tsp->getLowestTotalDistance() << endl;
	cout << "Average distance: " << tsp->getAverageDistance() << endl;
	cout << "Initial average distance: " << initialAverageDist << endl;

	delete tsp; // free memory

	return 0;
}


