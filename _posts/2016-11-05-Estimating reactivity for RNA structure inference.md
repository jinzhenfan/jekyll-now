---
layout: post
title: Comparison of two RNA structure models based on SHAPE-Seq data 
category: analysis
---

Due to the complexity of genomic datasets, the best approach to analyze data is often not clear from the beginning. In fact, several approaches and tools exist for analysis of most genomic datasets. Each approach is optimized and validated for specific datasets and may not be applicable across the board. However, due to lack of clear guidelines on when to use or not use an approach, data analysis teams sometimes end up taking suboptimal or even inapplicable approaches. This can lead to contradictory results between different studies on the same subjects. Such contradictions have to be resolved by careful examination of considerations/assumptions that may have motivated an approach.

In this article, we utilized SHAPE-Seq data sets from a Nature Letter publication$^1$, and compare the reactivity profiles obtained using the formula derived by Aviran et al., 2011 and another formula used by Ding et al., 2014. The maximum likelihood result obtained by Aviran et al can be found in the reference$^2$. Necessary details of Ding et al.'s research are given here but you are also encouraged to read the paper.$^1$

For any structure-profiling experiment, as described by Aviran et al., read mapping results can be tallied and summarized as stop counts for each nucleotide. Consider a transcript of length $n$. Let us label the nucleotides with indices 1 through $n$ with 1 being the 3' end. For this transcript, there will be $n+1$ count summaries for each of the experiment and control channel, also called as (+) channel and (-) channel, respectively. These counts can be denoted as $\big( X_1,X_2,..., X_n \big) $ for number of stops in (+) channel at nucleotides 1 through $n$ and similarly as $\big(Y_1,Y_2,... ,Y_n\big)$ for (-) channel. Let  $X_{n+1}$ and $Y_{n+1}$ represent the number of reads that map to the 5' end. Then, the two formulas to assess reactivity $\beta _k$ of a nucleotide $k$ are 

$ \beta _k = max \Big( \frac{\frac{X_k}{\sum_{i=k}^{n+1} X_i}-\frac{Y_k}{\sum_{i=k}^{n+1} Y_i}}{1-\frac{Y_k}{\sum_{i=k}^{n+1} Y_i}}, 0 \Big) $,(Aviran et al.) 


$$\beta_k = max \Big( \frac{ln(1+X_k)}{\frac{1}{n}\sum_{i=k}^{n+1} ln(1+X_i)}-\frac{ln(1+Y_k)}{\frac{1}{n} \sum_{i=k}^{n+1} ln(1+Y_i)}, 0 \Big), (Ding et al.)$$
 
