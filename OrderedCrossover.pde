import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class OrderedCrossover {
    int[] parent1;
    int[] parent2;
    int[] offspring;
    Map<Integer, Integer> geneCounts; // Track the number of times each gene is used in offspring
    Map<Integer, Integer> geneUsage; // Track the number of times each gene is currently used in offspring

    public OrderedCrossover(int[] parent1, int[] parent2) {
        this.parent1 = Arrays.copyOf(parent1, parent1.length);
        this.parent2 = Arrays.copyOf(parent2, parent2.length);
        this.geneCounts = new HashMap<>();
        this.geneUsage = new HashMap<>();
    }

    public int[] getOffspring() {
        return offspring;
    }

    /*private boolean containsGene(int gene, int[] genome) {
        for (int i = 0; i < genome.length; i++)
        {
           if (genome[i] == gene && geneUsage.getOrDefault(gene, 0) == geneCounts.getOrDefault(gene, 0)) 
             return true;
           }
        return false;
    }*/

 public void doCrossover() {
    this.offspring = new int[parent1.length];
    Arrays.fill(offspring, -1); // Fill offspring with a value that won't be in parent arrays

    // Get subset of parent chromosomes
    int substrPos1 = (int) (Math.random() * parent1.length);
    int substrPos2 = (int) (Math.random() * parent1.length);

    // Make the smaller the start and the larger the end
    final int startSubstr = Math.min(substrPos1, substrPos2);
    final int endSubstr = Math.max(substrPos1, substrPos2);

    // Copy the sub tour from parent1 to offspring
    for (int i = startSubstr; i < endSubstr; i++) {
        offspring[i] = parent1[i];
      }
    Map<Integer, Integer> geneCounts = new HashMap<>();
    for (int gene : parent1) {
      geneCounts.put(gene, geneCounts.getOrDefault(gene, 0) + 1);
    }

    // Track the count of values in offspring
    Map<Integer, Integer> offspringCount = new HashMap<>();
    for (int gene : offspring) {
        if (gene != -1) {
            offspringCount.put(gene, offspringCount.getOrDefault(gene, 0) + 1);
        }
    }
    // Loop through parent2's tour
    for (int i = 0; i < parent2.length; i++) {
        int gene = parent2[i];
        // Check if gene is not already in offspring or if it still needs to be added based on counts
        if (!offspringCount.containsKey(gene) || offspringCount.get(gene) < geneCounts.get(gene)) {
            // Find the next available slot in offspring
            for (int j = 0; j < offspring.length; j++) {
                if (offspring[j] == -1) {
                    offspring[j] = gene;
                    offspringCount.put(gene, offspringCount.getOrDefault(gene, 0) + 1);
                    break;
                }
            }
        }
    }
}

}
