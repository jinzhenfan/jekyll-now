---
layout: post
title: Comparison of two RNA structure models based on SHAPE-Seq data 
category: analysis
---

Due to the complexity of genomic datasets, the best approach to analyze data is often not clear from the beginning. In fact, several approaches and tools exist for analysis of most genomic datasets. Each approach is optimized and validated for specific datasets and may not be applicable across the board. However, due to lack of clear guidelines on when to use or not use an approach, data analysis teams sometimes end up taking suboptimal or even inapplicable approaches. This can lead to contradictory results between different studies on the same subjects. Such contradictions have to be resolved by careful examination of considerations/assumptions that may have motivated an approach.

In this article, we utilized SHAPE-Seq data sets from a Nature Letter publication$^1$, and compare the reactivity profiles obtained using the formula derived by Aviran et al., 2011 and another formula used by Ding et al., 2014. The maximum likelihood result obtained by Aviran et al can be found in the reference$^2$. Necessary details of Ding et al.'s research are given here but you are also encouraged to read the paper.$^1$

For any structure-profiling experiment, as described by Aviran et al., read mapping results can be tallied and summarized as stop counts for each nucleotide. Consider a transcript of length $n$. Let us label the nucleotides with indices 1 through $n$ with 1 being the 3' end. For this transcript, there will be $n+1$ count summaries for each of the experiment and control channel, also called as (+) channel and (-) channel, respectively. These counts can be denoted as $\big( X_1,X_2,..., X_n \big) $ for number of stops in (+) channel at nucleotides 1 through $n$ and similarly as $\big(Y_1,Y_2,... ,Y_n\big)$ for (-) channel. Let  $X_{n+1}$ and $Y_{n+1}$ represent the number of reads that map to the 5' end. Then, the two formulas to assess reactivity $\beta _k$ of a nucleotide $k$ are 

$$ \beta _k = max \Big( \frac{\frac{X_k}{\sum_{i=k}^{n+1} X_i}-\frac{Y_k}{\sum_{i=k}^{n+1} Y_i}}{1-\frac{Y_k}{\sum_{i=k}^{n+1} Y_i}}, 0 \Big),\qquad $$	(Aviran et al.) 


$$\beta_k = max \Big( \frac{ln(1+X_k)}{\frac{1}{n}\sum_{i=k}^{n+1} ln(1+X_i)}-\frac{ln(1+Y_k)}{\frac{1}{n} \sum_{i=k}^{n+1} ln(1+Y_i)}, 0 \Big),\qquad$$ (Ding et al.)

It is to be understood that the two formulas are motivated by differences in protocols. Aviran et al. derive their formula assuming that the data at hand is obtained by paired-end sequencing while Ding et al. optimize their formula for single-end sequencing. Additionally, note that the summations in Aviran et al.'s formula represent nucleotide-level coverage (or the number of reads mapping over a nucleotide) in respective channels while summations in Ding et al.'s formula represent overall coverage of transcript (or the total number of reads mapped to the transcript, with the addition of logarithmic transformation on read counts). 

### Plotting of reactivity profiles

In the first step, I wrote an R script to obtain reactivities using the two approaches, plot the reactivity profiles. 


```r
readsData <- read.table("pT181_Sense_112_adducts.txt", header= TRUE)   
readsData
treated_data=readsData$treated_mods
treated_data
untreated_data=readsData$untreated_mods
untreated_data
N<-nrow(readsData)
######Aviran's method#####
sumX<-sum(treated_data)
sumY<-sum(untreated_data)
betaA <- 0
for (i in 1:N){
	estimate <- (treated_data[i]/sumX - untreated_data[i]/sumY)/(1-untreated_data[i]/sumY)
	sumX <- sumX-treated_data[i]
	sumY <- sumY-untreated_data[i]
	betaA[i] <- max(estimate,0)
}
#####Ding's method######
sumX<-sum(log(treated_data+1))
sumX
sumY<-sum(log(untreated_data+1))
sumY
betaD <- 0
for (i in 1:N){
	estimate <- log(treated_data[i]+1)*N/sumX - log(untreated_data[i]+1)*N/sumY
	betaD[i] <- max(estimate,0)
}

plot(1:N, betaA, type="l", col = "red", xlab="Position",ylab="Reactivity")
lines(1:N, betaD,  col = "blue")
legend(20,1, c("Aviran", "Ding"),lty=c(1,1), col=c('red','blue'),cex=0.8,) 
```

### Reactivity profiles:

The figure generated shows that the two formulas yield different profiles.

![alt text](https://rawgit.com/jinzhenfan/jinzhenfan.github.io/master/images/RNAseq/Reactivity4.jpeg)

### Special cases that yield high correlation

In the absence of (-) channel noise (i.e., $Y_i=0$ for all $i$) and uniformity of coverage across the transcript (i.e., nucleotide-level coverage is equal for all nucleotides), we will see that both formulas would yield well-correlated profiles, if measuring correlation by Spearman rank correlation.

First, if we assume the absence of (-) channel noise and nucleotide-level coverage is equal for all nucleotides, both formula can be changed to the following format:


where c is a constant representing nucleotide-level coverage. 

Then we have the profiles changed as shown on the Figure1 (Note that red line is scaled by 30 fold for visualization convenience). 
The Spearman rank correlation calculated in R is 1, suggesting that in this case two profiles are highly correlated.

### Differences between Spearman and Pearson Correlation

However, Pearson correlation is only 0.598, not as high as spearman. This is caused by the fact that Spearman correlation coefficient is based on the ranked values for each variable rather than the raw data. In general, Pearson measures linear relationships, and Spearman measures monotonic relationships. Two variables get high Pearson correlation coefficient when one variable is associated with a proportional change in the other variable. In contrast, two variables get high Spearman rank correlation coefficient when the variables tend to change together, but not necessarily at a constant rate. 

**Advantages of using Spearman:** It can find the similarity in both methods, although it is not intuitive to judge from the profile figure. And easy to validate that Aviran's methods can generate high reactivity estimate on the nucleotides where Ding's method gave a high reactivity estimate.

**Disadvantages of using Spearman:** It neglect the fact that two methods generate very different scores in some positions, and the relationship is not proportional. Aviran's method tend to have more peaks that exhibit much higher value than the surroundings, and tend to have a decay trend from right to left on the graph. This part of information is missed. 






