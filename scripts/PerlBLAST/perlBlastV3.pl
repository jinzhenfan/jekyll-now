#！/usr/bin/perl

open IN, "query.txt";
$Q=<IN>;
chomp $Q;

#print "$Q\n";
$/="";                                           # Read in a string in a database in format of paragraphs instead of lines.



#print "Input the length of the window\n";               #Input length of windows, which is k
$k = 4;
#chomp $k;

#print "Please input the threshold t for matching length.\n";#Input the threshold of matching length
$t = 7;
#chomp $t;


@string1 =  split(//, $Q); #split query string into array $string1 for scoring later.

%kmerQ = ();               #Put the kmers in query string into a hash table %kmerQ.       
$i = 1;
while (length($Q) >= $k) {
  $Q =~ m/(.{$k})/; 
#  print "$1, $i \n";
  if (! defined $kmerQ{$1}) {     
    $kmerQ{$1} = [$i];                           # Use an array instead of a number to record the occurence of kmer in query sequence.
   }
    else { push (@{$kmerQ{$1}}, $i)}             # If the array already exists for a kmer, add additional position info into the array
 $i++;
 $Q = substr($Q, 1, length($Q) -1);
}


#foreach $kmerkey (keys(%kmerQ)) {
# print "The occurrence of string $kmerkey is in position",#print occurrence of all kmers in Q
# join(" ", @{$kmerQ{$kmerkey}}), "\n";           #use @{hashtable{key}} to iterate through the array of each value
#}


open IN, "genbank.txt";                   #Read in the database to be searched
#$/="";                                           # Read in a string in a database in format of paragraphs instead of lines.
while ( $S = <IN>) {                             # Read in one string S from the Database
#  print $S;
                                    #Find all kmer in S
  %kmerS = ();                      # This initializes the hash called kmerS to store first occurence of all kmers in S.
  %stringhash=();
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
  
  foreach $kmerkey (keys(%kmerS)) {      # For each kmer in S, check whether it matches with kmers in Q.
    if  (defined $kmerQ{$kmerkey}){      # If it matches a kmer in Q, Split characters in S into string2 for scoring
     @string2 =  split(//, $S);                                
     foreach (@{$kmerQ{$kmerkey}}) {     # Iterate through all occurence positions of the matched kmer in the query string.
       $L=$k;                            # This initializes scores as k.
       $L_prev=$k;
                                         # compare and score
                                         # Towards right
       $m=$_+$k-1;                       # Assign the first position behind the current matched kmer in Q and S to m and n.
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
       $m=$_-2;                          # Assign the first position before the current matched kmer in Q and S to m and n.
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
       
       if ($L>=$t and ! defined $stringhash{$n+1})  {                    # Check whether it is a HSP with score higher than T and haven't been reported.
         $stringhash{$n+1}=1;                                           # If not, mark it as reported.
 
         print "A good HSP scoring $L has been found in the following string:\n";   # Print the score.
         print "$S\n";                                                                #Print the matched string in the database.
       }
       # print "$kmerkey $_\n";
      }
    }
  }
}
=commentstart
For k=3 and t=6, the highest matching score is 7.
For k=4 and t=6, the highest matching score is 7.
For k=3 and t=7, the highest matching score is 7.
For k=4 and t=7, the highest matching score is 7.

=commentend
