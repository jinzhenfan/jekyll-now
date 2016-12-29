---
layout: post
title: Gene Regulatory Network Inference based on Random Forests
category: analysis
---

In this blog, I will build a gene regulatory network from gene expression data using Random Forests and perform a functional analysis for that network. 

### Datasets

I use a dataset from a microarray experiment of _Escherichia coli K-12_ strain to investigate biofilm formation in the first 24 hours of the culture. 

The paper that describes this experiment is the following:
Domka J, Lee J, Bansal T, Wood TK. Temporal gene-expression in Escherichia coli K-12 biofilms. Environ Microbiol. 2007 Feb;9(2):332-46.
And you can download it from:
[http://www.ncbi.nlm.nih.gov/pubmed/17222132](http://www.ncbi.nlm.nih.gov/pubmed/17222132)

### Random Forests

The paper that describes how this method work has been published in PLoS One in 2010 and can be viewed here:

[http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0012776](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0012776)

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/RF/RF.png)

Our method makes the assumption that the expression of each gene in a given condition is a function of the expression of the other genes in the network (plus some random noise). Say we have p genes in the network: 

1. For $j$ =1 to $p$, 

	a. Generate the learning sample of input-output pairs for gene $j$, where the vector of expression of all genes except $j$ is the input denoted by $X$, and the expression of gene $j$ is the output denoted by $Y$. Construct a training set $X$ = $x_1, ..., x_n$ with responses $Y$ = $y_1, ..., y_n$.

	b.  Build a Random Forests ensemble. 

		..1. Sample with replacement from the training set (B times); call these $X_b$, $Y_b$.

		..2. Train a decision or regression tree fb on $X_b$, $Y_b$.

		..3. At each candidate split in the learning process, a random subset of the features/attributes are selected. This process is sometimes called "feature bagging". In this case, different subsets of genes are selected.

		..4. Different algorithms use different metrics as criteria to split at each nodes, such as, Gini Impurity and information gain. (One example of training decision trees based on information gain:
[http://christianherta.de/lehre/dataScience/machineLearning/decision-trees.php](http://christianherta.de/lehre/dataScience/machineLearning/decision-trees.php))

		..5. Generally, after training, predictions for unseen samples $x'$ can be made by averaging the predictions from all the individual regression trees on $x'$, or by taking the majority vote in the case of decision trees.

	c. In this case, for a single tree, the overall importance of one variable is then computed by summing the importance measure of all tree nodes where this variable is used to split. 

2.  Aggregate the $p$ individual gene rankings to get a global ranking of all regulatory links.


### Gene Regulatory Network Inference using GENIE3

### Functions of Regulating Genes






