# Improvement ideas

### Data scientist's wiki:
* Link for raw code for dat scientist’s primer needs an update
* CATALYST bead norm. should be mentioned
* Live.Rdata object should be updated to reflect changes
* 3D + interactive plot embeddings dont work: {“type”:“data”, “dataset”:“59afbf1da6b06402ace2194d”, “subset”:“null”}, {“type”:“data”, “dataset”:“59afc3b6a6b06402ace2194e”, “subset”:“null”}
* Add clustree to data scientist’s primer
* Come up with better cydar example - nothing significant in current?
* Make nicer tables
* Make nicer FlowSOM MST
* Clustering - Bayesian framework https://arxiv.org/abs/2002.08609
* Get section numbering back

### Cytometrist's wiki:
* Comparison of dimensionality reduction methods (and local vs global conservation)
* Basic statistics appendix: Multiple testing correction/FDR, in plain English: e.g. like http://www.biostathandbook.com/multiplecomparisons.html

Like, "You have 16 PBMC samples (8 cases, 8 controls), each with ~150,000 Live Intact Singlets.  You used 30 markers in your FlowSOM clustering, which gave you a total of 50 clusters ranging in size from 0.1% to 10% of each file.  In this case, your number of tests would be [30, rather than 50?].  Your p-value [would?] change depending on the fractional size of the cluster.  If instead you had 160 samples (80 case and 80 controls), your results [would?] change in this way" and so forth.  
