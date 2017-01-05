---
layout: post
title: RNA-Seq Mapping by GALAXY
category: analysis
---

In Genomic data analysis, new algorithms are coming out every day. We often hear about new topics on mapping algorithms such as TopHat, Cufflink, FASTAQ, and so on. However, for researchers, the problem is where to access these new algorithms and how to process their own datasets with them conveniently. 

Now you have a shortcut in a software suite called [**GALAXY**](https://galaxyproject.org/)! 

In this blog, I will walk you through GALAXY to analyze five RNA-Seq datasets. 

### Overview

The **GALAXY** Project is an open, web-based platform for data intensive biomedical research. Whether on the free public server or your own instance, you can perform, reproduce, and share complete analyses. It is supported in part by NHGRI, NSF, the Huck Institutes of the Life Sciences, the Institute for CyberScience at Penn State, and Johns Hopkins University. 

The **datasets** we are using today are paired-end 50bp reads from adrenal and brain tissues (500Kb region of chromosome 19, chr19:3000000:3500000). The datasets contain the transcriptional profiles in those tissues and our task is to find genes that are differentially expressed (DEG) in the sample conditions versus the control sample. You can download the datasets [here](https://usegalaxy.org/u/jeremy/p/galaxy-rna-seq-analysis-exercise). It is recommended to look through the tutorial in the same link for detailed steps. 

### Layout

Once you are in the [mainpage](https://usegalaxy.org/), a list of operations/algorithms are shown in the leftmost panel called tools. Once you click on any operation, it will pop up a setting windows. Once it is done, this operation will show up on the rightmost panel called History. 

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/GALAXY/ss1.png)

Then we can start importing data and perform our own RNA-Seq gene differential expression analysis. 

[Here is a link to my workflow.](https://usegalaxy.org/u/galaxygirl/h/imported-rna-seq-exercise-datasets)

### Loading data and QC

The first thing we want to do here is to load in the data. You can import the five RNA-Seq datasets [here](https://usegalaxy.org/u/jeremy/p/galaxy-rna-seq-analysis-exercise) by clicking on the _import History_ button. It will show up in your current history after a few minutes. As we are doing remote database operation in queue by using this website, most operations will be relatively slow. 

Once data is loaded, you can click on the left tool panel, and do the operation as instructed. 

After loading data, I did a _FastQC_ for quality control check on the data. Actually no data needs trimming. 

### Sequence Mapping and Visualization

Then _TopHat_ algorithm is performed on individual raw Illumina sequencing datasets, to align and map all the reads to transcripts according and figure out all splice junctions.

Here is a visualization of RNA-Seq mapping of brain tissue data sets. Visualization function is provided by the GALAXY website.

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/GALAXY/ss3.png)

And the mapping of adrenal tissue data sets.

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/GALAXY/ss4.png)

### Gene Differential Expression Analysis

_Cufflink_ is performed subsequently to analyze assemble differential gene expressions based on these assembled transcripts. Comparing with Genome annotation of hg19 on the top, we can have a intuitive understanding of the differentially expressed genes in brain and adrenal data sets.

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/GALAXY/ss5.png)

Eventually, we can sort and filter on the top 100 DEG, to get novel transcripts of our interest for further study. 

[Download the Top 100 DEG here.](https://github.com/jinzhenfan/jinzhenfan.github.io/blob/master/scripts/GALAXY/Top100DEGCuffDiff.txt)

Have fun working with differential gene expression!












