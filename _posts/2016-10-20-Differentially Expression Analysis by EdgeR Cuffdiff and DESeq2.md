---
layout: post
title: Differentially Expression Analysis by Cuffdiff, EdgeR, and DESeq2 
category: analysis
---

In this blog, I will talk about the following topics:
* What is DEG and why it is so popular
* What is the differences between Cuffdiff, EdgeR, and DESeq2
* How to preprocess your data from the Sequencer
* How to get DEG analysis results usign R packages
* Visualization of DEG

### Background

Differential Gene Expression is becoming a hot topic in fundenmental science research now, with the advancement of Next Generation Sequencing and single-cell isolation technology. The original question is, if the genome is the same in all somatic cells within an organism (with the exception of the above-mentioned lymphocytes), how do the cells become different from one another? How come that your red bllod cells produce hemoglobin, while your  cardiomyocytes controls your heart beating? The answer is differential gene expression.

Although every cell containes the same complete genome DNA, only a small percentage of the DNA is selectively expressed in each cell, therefore a specific portion of the RNA is synthesized in that cell type. For instance, if your body is a comparable to a country, then each cell is a individual person in this community. Before differential gene expression is studied, we only have the base knowlege of the this country as a whole. The ultimate goal of differential gene expression is to obtain the portfolio the race, occupation, and personality of each individual. 

Being able to recognize differential gene expression, is a key to understanding the specific roles that a cell is playing, or cell mutation. Thus it is becoming crucial for understanding the initial development of diseases, such as cancers and diabetes, growth of organs in childhood, as well as monitoring the influence of environment change. The expression level of each RNA unit is measured by the number of sequenced fragments that map to the transcript, which is expected to correlate directly with its abundance level. 


### Algorithms and tools 

In this blog, I will walk you through several algorithms that serves to answer the question that why cell from different tissues act differently, more specificly, which genes are expressed in one tissue but not in the other tissue. This topic is also known as DEG(Differentially expressed genes). 

**GALAXY** is a free public server for DEG analysis, which I have introduced in a previous [blog](https://jinzhenfan.github.io/RNA-Seq-Mapping-by-GALAXY/). Here I will mainly introduce **edgeR** and **DESeq2**. 

R packages for edgeR can be found here.
[http://www.bioconductor.org/packages/release/bioc/html/edgeR.html](http://www.bioconductor.org/packages/release/bioc/html/edgeR.html)

R packages for DESeq2 can be found here.
[http://bioconductor.org/packages/release/bioc/html/DESeq2.html](http://bioconductor.org/packages/release/bioc/html/DESeq2.html)


### Datasets

Here we take brain cells and adrenal cells for example. We are using the same data sets used in GALAXY blog. The datasets are paired-end 50bp reads from adrenal and brain tissues (500Kb region of chromosome 19, chr19:3000000:3500000). You can find the datasets here:
[https://usegalaxy.org/u/jeremy/p/galaxy-rna-seq-analysis-exercise](https://usegalaxy.org/u/jeremy/p/galaxy-rna-seq-analysis-exercise)








