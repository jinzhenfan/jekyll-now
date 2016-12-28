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

Then we change the direct input to reading in from a file a query string Q.

```perl
print "Please input the name of a file to be read.\n";
$infile=<>;
open IN, "$infile";
$Q=<IN>;
chomp $Q;
print "$Q\n";
```

For k = 4, use program kmerfirst.pl to find the first location of each different k-mer in Q.

```perl
@string1 =  split(//, $Q);
%kmerQ = ();               #Put the kmers in query string into a hash table %kmerQ.       
$i = 1;
while (length($Q) >= $k) {
  $Q =~ m/(.{$k})/; 
  print "$1, $i \n";
  if (! defined $kmerQ{$1}) {     
    $kmerQ{$1} = $i;                           
   }
 $i++;
 $Q = substr($Q, 1, length($Q) -1);
}


foreach $kmerkey (keys(%kmerQ)) {
 print "The first occurrence of string $kmerkey is in position $kmerQ{$kmerkey}\n";          
}

```

Successively read in one string at a time from a file called perlblastdata.txt, which is our sequence database.. When a string S is read in, scan through its 4-mers, using the same hash as before. 

```perl
open IN, " testcase2.txt ";                   #Read in the database to be searched
while ( $S = <IN>) {                             # Read in one string S from the Database
  print $S;
                                    #Find all kmer in S
  %kmerS = ();                      # This initializes the hash called kmerS to store first occurence of all kmers in S.
   $i = 1;
  $S_temp = $S;
  while (length($S_temp) >= $k) {
    $S_temp =~ m/(.{$k})/; 
    # print "$1, $i \n";
     if (! defined $kmerS{$1}) {     
      $kmerS{$1} = $i;       
     }
   $i++;
   $S_temp = substr($S_temp, 1, length($S_temp) -1);
  }
  
  foreach $kmerkey (keys(%kmerS)) {      
     print "$kmerkey is in position $kmerS{$kmerkey}";
  }
}

```


Whenever a 4-mer in S is determined to be in Q, extract the location of the first occurrence of that 4-mer in Q. Then put the characters of Q and S in arrays (as we did in needleman.pl) so that you can examine individual characters. Then scan left from the k-mer in Q and in S, as long as you find matching characters. Repeat to the right. Let L denote the length of the whole match obtained in this way. If L is greater than 10, then print a message that a good HSP has been found between Q and S, and print S.Notice that the same HSP gets reported multiple times.

```perl
foreach $kmerkey (keys(%kmerS)) {      

     if (defined $kmerQ{$kmerkey}){      # If it matches a kmer in Q, Split characters in S into string2 for scoring
      @string2 =  split(//, $S);                                
      $L=$k;                            # This initializes scores as k.
      $L_prev=$k;
                                         # compare and score
                                         # Towards right
      $m=$kmerQ{$kmerkey}+$k-1;                       # Assign the first position behind the current matched kmer in Q and S to m and n.
      $n=$kmerS{$kmerkey}+$k-1;
      while ($L>=$L_prev){
         $L_prev=$L;
         if ($string1[$m] eq $string2[$n]){  #If the extension matches, add score by one, and proceed to the next
          $L++;
          $m++;
          $n++;
         } else { $L--;}                     # Otherwise, stop extension.
      }
      $L=$L_prev;  
                                         # Towards left
      $m=$kmerQ{$kmerkey}-2;                          # Assign the first position before the current matched kmer in Q and S to m and n.
      $n=$kmerS{$kmerkey}-2;
      while ($L>=$L_prev){
         $L_prev=$L;
         if ($string1[$m] eq $string2[$n]){    # If the extension matches, add score by one, and proceed to the next
          $L++;
          $m--;
          $n--;
        } else { $L--;}                       # Otherwise, stop extension.
      }
       $L=$L_prev;
       
      if ($L>10 )  {                    # Check whether it is a HSP with score higher than T and haven't been reported.

         print "A good HSP scoring $L has been found in the following string:\n";   # Print the score.
         print "$S";                                                                #Print the matched string in the database.
      }
    }
  }

```

Now we will alter the code so that HSP are not reported multiple times. We can do it using a hash called stringhash: Whenever PERL-BLAST finds a reportable substring in a database, starting at position \\$i (e.g. in the database string), it searches whether \\$stringhash{\\$i} is defined. If it is, it does not report the string again. Otherwise it assigns the string to \\$stringhash{\\$i} and reports the string.

```perl
  %stringhash=();
...
       if ($L>10 and ! defined $stringhash{$n+1})  {                    
         $stringhash{$n+1}=1; 
         print "A good HSP scoring $L has been found in the following string:\n\n"; 
         print "$S";                                                  
      }

```

We would like to process strings that are more than a single line long. So in the file each string will be held in consecutive lines, with strings separated by blank lines. That is analogous to each string being a paragraph instead of just a single line. To read in a paragraph, put the following line


```perl
$/ = "";
```

somewhere in the program before the string is read.

Finally, we will make it so that if a k-merthat is present in the database string is also in the query string in multiple locations, then a search should be made from each occurrence of the k-mer in the query string, spanning outward left and right of each occurrence. 

```perl
...
  if (! defined $kmerQ{$1}) {     
    $kmerQ{$1} = [$i];                     # Use an array instead of a number to record the occurence of kmer in query sequence.
   }
    else { push (@{$kmerQ{$1}}, $i)}             # If the array already exists for a kmer, add additional position info into the array
 $i++;
 $Q = substr($Q, 1, length($Q) -1);
}


foreach $kmerkey (keys(%kmerQ)) {
 print "The occurrence of string $kmerkey is in position",#print occurrence of all kmers in Q
 join(" ", @{$kmerQ{$kmerkey}}), "\n";           #use @{hashtable{key}} to iterate through the array of each value
}

```

### Congratulations, you made your own version of BLAST!

Here is my outcomes:

```
Please input the name of a file to be read.
Query2.txt
wqsgqrwelalgrfwdylrwvqtqrwelalgrfwdylrwvqt
Input the length of the window
4
Please input the threshold t for matching length.
10

A good HSP scoring 23 has been found in the following string:
mkvlwaallvtflagcqakveqavetepepelrqqtewqsgqrwelalgrfwdylrwvqt
lseqvqeellssqvtqelralmdetmkelkaykseleeqltpvaeetrarlskelqaaqa
rlgadvlashgrlvqyrgevqamlgqsteelrvrlashlrklrkrllrvlashqkrlavy
qagaregaerglsairerlgplveqgrvraatvgslagqplqeraqawgerlrarmeemg
srtrdrldevkeqvaevrakleeqaqqirlvlashqarlkswfeplvedmqrqwaglvek

A good HSP scoring 19 has been found in the following string:
mkvlwaallvtflagcqakveqavetepepelrqqtewqsgqrwelalgrfwdylrwvqt
lseqvqeellssqvtqelralmdetmkelkaykseleeqltpvaeetrarlskelqaaqa
rlgadvlashgrlvqyrgevqamlgqsteelrvrlashlrklrkrllrvlashqkrlavy
qagaregaerglsairerlgplveqgrvraatvgslagqplqeraqawgerlrarmeemg
srtrdrldevkeqvaevrakleeqaqqirlvlashqarlkswfeplvedmqrqwaglvek

Press any key to continue ...

```

