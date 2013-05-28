
This repository contains the source for the paper
[Broman KW (2012) Genotype probabilities at intermediate generations in the construction of recombinant inbred lines. Genetics 190:403-412](http://www.ncbi.nlm.nih.gov/pubmed/22345609)

This is a complex and quite theoretical paper with lots of complicated
algebraic results.

The
[Calculations](https://github.com/kbroman/preCCProbPaper/tree/master/Calculations)
directory contains all of the primary results.  For each of various
different situations, I have plain text files (e.g.,
[this one](https://github.com/kbroman/preCCProbPaper/blob/master/Calculations/Selfing/Inputs/pi_k.txt)),
there are simple-to-parse versions of the algebraic expressions plus a
perl script that converts them into Maxima code, R code, and LaTeX
code.  The Maxima and R versions are used to check the results,
symbolically and numerically.  The LaTeX versions are ultimately
incorporated into the paper.

The [Perl](https://github.com/kbroman/preCCProbPaper/tree/master/Perl)
directory contains scripts that create the
[LaTeX tables](https://github.com/kbroman/preCCProbPaper/tree/master/Tables)
in the paper.

The files
[preCCprob_notab.tex](https://github.com/kbroman/preCCProbPaper/tree/master/preCCprob_notab.tex)
and
[preCCprob_supp_notab.tex](https://github.com/kbroman/preCCProbPaper/tree/master/preCCprob_supp_notab.tex)
contain the primary manuscript.  The tables get added to create the
final latex files
[preCCprob.tex](https://github.com/kbroman/preCCProbPaper/tree/master/preCCprob_notab.tex)
and
[preCCprob_supp.tex](https://github.com/kbroman/preCCProbPaper/tree/master/preCCprob_supp_notab.tex).

[![CC BY](http://i.creativecommons.org/l/by/3.0/88x31.png)](http://creativecommons.org/licenses/by/3.0/)
