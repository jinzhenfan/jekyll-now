---
layout: post
title: Create a toy BLAST search tool 
category: analysis
---

BLAST is one of the most widely used bioinformatics algorithms for sequence searching. It addresses a fundamental problem in bioinformatics research. The heuristic algorithm it uses is much faster than other approaches, such as calculating an optimal alignment. This emphasis on speed is vital to making the algorithm practical on the huge genome databases currently available. 

[View the BLAST mainpage here](https://blast.ncbi.nlm.nih.gov/Blast.cgi)

### What is the difference between BLAST, BLAST 2, PSI-BLAST, FASTA? When should each of these been used (trade-offs)?

The **FASTA** program follows a largely heuristic method which contributes to the high speed of its execution. It initially observes the pattern of word hits, word-to-word matches of a given length, and marks potential matches before performing a more time-consuming optimized search using a Smith-Waterman type of algorithm. FASTA cares about all of the common words in the database and query sequences that are listed in the k-letter word list. 

**BLAST** is also a heuristic algorithm, but it select only the high-scoring words from a database to find optimal alignment. Thus, BLAST is more time-efficient than FASTA by searching only for the more significant patterns in the sequences, yet with comparative sensitivity.

**BLAST2**, a newer version of BLAST, adopts a lower neighborhood word score threshold to maintain the same level of sensitivity for detecting sequence similarity. BLAST2 can save more time Therefore, the possible matching words list becomes longer. 

Position-Specific Iterative BLAST (**PSI-BLAST**) is used to find distant relatives of a protein. First, a list of all closely related proteins is created. These proteins are combined into a general "profile" sequence, which summarizes significant features present in these sequences. A query against the protein database is then run using this profile, and a larger group of proteins is found. This larger group is used to construct another profile, and the process is repeated. By including related proteins in the search, PSI-BLAST is much more sensitive in picking up distant evolutionary relationships than a standard protein-protein BLAST. 

In summary, when one want to explore distant evolutionary relationships of proteins, or find distant relatives of a protein, PSI-BLAST should be used. If one want to do a detailed search of optimal alignment of nucleotide or protein sequences in databases and not to miss any possible matches, FASTA should be used. However, it might take relatively long time. If one want to search for optimal alignments within a short period of time and narrow down the candidate pool, BLAST should be used. Further, if BLAST is not fast enough, and one does not care length of possible matching words list, BLAST2 can be adopted. 

[Wikipedia](https://en.wikipedia.org/wiki/BLAST)


### Create a PERL-BLAST algorithm

Here we will create a toy blast program that we will call **PERL-BLAST**. It will use the same principles as BLAST does, for finding seed words first (kmeres) and then extending them to find potential alignments. The elements of Perl that you will use include the substr function, the length function, data structures such as two-dimensional hashes and lists, the defined function. For better understanding, I encourage you to read any Perl book (like Johnson's) or online resource regarding these functions and data structures.

The program starts with coding a kmerfirst.pl to find the first position of each of the different kmers of length k. This program will be the starting point for your PERL-BLAST program.

```perl
#!/pkg/bin/perl -w
# Program kmerfirst.pl
# This program finds all the overlapping k-mers of the input string. It builds
# an associative array where each key is one distinct k-mer in the string,
# and the associated value is the starting position where that
#k-mer is FIRST found.  

print "Input the string\n";
$dna = <>;
chomp $dna;
print "Input the length of the window\n"; 
$k = <>;
chomp $k;

%kmer = ();                      # This initializes the hash called kmer.
$i = 1;
while (length($dna) >= $k) {
  $dna =~ m/(.{$k})/; 
  print "$1, $i \n";
   if (! defined $kmer{$1}) {     #defined is a function that returns true
                                  # if a value has already been assigned to
                                  # $kmer{$1}, otherwise it returns false. 
                                  # the ! character is the negation, so
                                  # if $kmer{$1} has no value, then it will
                                  # be assigned the value of $i, the position
                                  # where the k-mer is first found.
    $kmer{$1} = $i;       
   }
 $i++;
  $dna = substr($dna, 1, length($dna) -1);
}

foreach $kmerkey (keys(%kmer)) {
 print "The first occurrence of string $kmerkey is in position 
 $kmer{$kmerkey}\n";
}

```

