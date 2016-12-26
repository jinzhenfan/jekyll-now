---
layout: post
title: Deep Learning in Genomics
---

## Deep Learning for Predicting Sequence Specificities of DNA/RNA Binding Proteins 

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/14.png)

The paper I want to review is named Predicting the Sequence Specificities of DNA- and RNA-binding Proteins by Deep Learning published on Nature Biotechnology 2015. I am personally interested in this article, because of two reasons. First, I recently worked with synthetic biologists to optimize the quantity of transcription factors, which belongs to DNA-binding proteins, and it helps me develop better understanding by studying the most advanced research about it. Second, I am curious about how to apply deep learning in DNA/RNA sequences in general, the advantages and obstacles. 

### Why deep learning? 

As a matter of fact, researchers has been exploring different methods for predicting sequence specificities of DNA/RNA binding proteins, such as MatrixREDUCE, MEMERIS, Covariance models, and RNAcontext, etc. Then what we can gain from this deep learning method? I summarize the following reasons:

* It outperforms all the aforementioned methods with both in vivo and in vitro datasets in predicting DNA- and RNA- binding protein specificities. 
- Ease of training across different measurement platforms, such as Protein-DNA Binding Microarray (PBM), Chromatin Immunoprecipitation (ChIP) Assays, and HT-SELEX. 
+ Parameter tuning is automatic, more generic and less labor intensive for new datasets.

### How is Sequence Specificities Measured?

Before taking a look into the model, one need to get a basic idea about how those input datasets are generated.[9-13]

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/1.png "Experimental ways to collect DNA- RNA- binidng protein datasets")

PBM utilizes microarray chips where an array of capture DNA strands is bound, typically labelled by probe molecules. ChIP methods works by forming and isolating immuno-complex at the binding sites, which works well in vivo. SELEX (systematic evolution of ligands by exponential enrichment) is a method to enrich small populations of bound DNAs from a random sequence pool by PCR amplification.

### Workflow

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/2.png)

The overall workflow includes feed-forward stages and back-propagation stages. Feed-forward stages contains sequence conversion, convolution, rectification, pooling, and neural networks. We will talk about each in detail below. 

### Sequence Conversion

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/3.png)

The first step is to convert the sequences in the datasets into proper mathematical representations. Let's say we have n sequences as inputs. In this step, extra padding of length m-1 is inserted at the head and tail of each sequence, permitting detection at extreme ends. m is the length of motifs. Meanwhile, the number of input sequences doubles. Because typically when one sequence is measured with high DNA- or RNA-binding affinity, we are not sure whether it is the given strand or its reverse strand that is dominating. Thus both given sequences and their reverse strands are used as inputs for the following steps. Mathematically, the conversion formula is:

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/4.png)


![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/5.png)

### Convolution

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/6.png)

### Rectification and Pooling

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/7.png)

### Neural Network with Dropout

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/8.png)

### Training Objectives

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/9.png)

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/10.png)

### Back-propagation Stages

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/11.png)

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/12.png)

### Automatic Parameter Calibration


![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/DeepLearningDNAbindingProteins/13.png)

### Dataset Sizes and Shortcomings

### Conclusion

This article has done a great job balancing the number of models, complexity of models and parallel computing. It is very helpful to learn the ways they pre-process sequence data, extract features, and calibrate the parameters. Later this model has been used in identifying diseases-related variants in the sequences of DNA- and RNA- binding proteins, setting a great example for applying deep learning models in biomedical research. 

1111

