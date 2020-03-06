# Improvement ideas

### Data scientist's wiki:
* Link for raw code for data scientist’s primer needs an update
* CATALYST bead norm. should be mentioned
* 3D + interactive plot embeddings dont work: {“type”:“data”, “dataset”:“59afbf1da6b06402ace2194d”, “subset”:“null”}, {“type”:“data”, “dataset”:“59afc3b6a6b06402ace2194e”, “subset”:“null”}
* Add clustree to data scientist’s primer
* Make nicer tables
* Make nicer FlowSOM MST
* Clustering - Bayesian framework https://arxiv.org/abs/2002.08609
* "uncleaned" tSNE (or clustering) example - what happens when you don't pre-gate (people do this and it's hard to diagnose the problem)
* Expand on batch correction algorithms
* Mike: "In the Cytometrist's Primer, under Citrus:  "Since the clustering is hierarchical, one should be aware that the clusters are not mutually exclusive and some cells will be present in more than one cluster. The central cluster (Number 1 on the figure below) contains all cells, Cluster 2 contains a subset of the cells in cluster 1, cluster 3 contains a subset of the cells in cluster 2, etc."
- Is there a figure missing there?  I don't see any node labelings.  I seem to recall a nice "nested" set of circles in the previous version of Biosurf, which more clearly explained the point....."
* Consider adding data sets from mike's list
* MetaCyto tool looks very interesting
* clustRcheck could also be valuable

### Cytometrist's wiki:
* Comparison of dimensionality reduction methods (and local vs global conservation)
* Basic statistics appendix: Multiple testing correction/FDR, in plain English: e.g. like http://www.biostathandbook.com/multiplecomparisons.html

Like, "You have 16 PBMC samples (8 cases, 8 controls), each with ~150,000 Live Intact Singlets.  You used 30 markers in your FlowSOM clustering, which gave you a total of 50 clusters ranging in size from 0.1% to 10% of each file.  In this case, your number of tests would be [30, rather than 50?].  Your p-value [would?] change depending on the fractional size of the cluster.  If instead you had 160 samples (80 case and 80 controls), your results [would?] change in this way" and so forth.  
