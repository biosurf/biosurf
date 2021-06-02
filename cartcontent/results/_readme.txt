The analyses with the following tools were performed on all the CarT targets (61) listed in the table "data/data-2020-11-26.csv". Subsequently, we have decided to focus only on the CarT targets that were used in clinical trials featuring TCGA tumors. We also decided to exclude blood cancers from the analyses. 
This is the reason why the analyses with the tools listed below were performed on 61 targets, while the subsequent analyses and the isoform plots, as well as the html files are made only for 28 targets. 

BepiPred
column EpitopeProbability describes the probability that the residue is part of a B cell epitope. If prob > 0,5 the residue is considered to be part of the epitope. 

Netphosphan 
position corresponds to phosphorylated aa. The phosph aa is the one at position 11 of the peptide (21aa). 

NetOGlyc
column strand and/or frame indicates the position of each residue. If the last column contain "positive" it means that the residue is glycosylated. A residue is considered glycosylated if score is > 0.5. 

SignalP (crosref uniprot) y/n
The residues that have "S" in the "SP" column are part of the signal peptide. 

topcons
no table. just a sequence of letters where S is signal peptide, o is the ectodomain, M is a-helix tm, i is the intracellular segment. --> use it to identify which aa are:
- S
- o
- i

deeploc (crossref uniprot) y/n
It gives back the likelihood of different subcellular localization. 
