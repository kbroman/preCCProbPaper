
Perl scripts

I create a bunch of plain text files with basic results.  These get
parsed into LaTeX tables for the paper and Supplement as well as into
Maxima code (for testing and calculatong) and also R code (for testing
and making figures).

The scheme is that there's one set of files with the key results that
get translated directly into the tables that appear in the paper and
into other forms for direct software checks, both symbolically (with
Maxima) and numerically (with R).

I wish I had been more careful in inserting comments!


insert_tables.pl

  Insert tables into the LaTeX document

  preCCprob_notab.tex -> preCCprob.tex
  preCCprob_supp_notab.tex -> preCCprob_supp.tex


make_8w_state_supp_tables.pl

  Make Table S23 with all 8-way states

    Input:  Calculations/Eightway/statesA8_rev.txt

    Output: Tables/statesA8_supp_table.tex


make_fixation_table.pl

  Make Table 3 with fixation probabilities

    Input:  Calculations/OnelocusA4/Inputs/fixation.txt
            Calculations/OnelocusX4/Inputs/fixation.txt

    Output: Tables/fixation_table.tex


make_hap_tables.pl                

  Make the LaTex table with haplotype probabilities

    Input:  Calculations/TwolociA4/hap_rev.txt
            Calculations/TwolociX4/female_hap_rev.txt
            Calculations/TwolociX4/male_hap_rev.txt

    Output: Tables/haplotype_table.tex


make_hap_tm_table.pl

  Make Supplemental tables with haplotype transition matrix

  hap_matrix.txt + hap_state.txt -> Tables/hap_*_tm_supp_table.tex


make_map_expansion_table.pl

  Make Table 5 with map expansions

  Input:  Calculations/TwolociA4/map_expansion.txt
          Calculations/TwolociX4/map_expansion.txt
          Calculations/Selfing/map_expansion.txt

  Output: Calculations/Selfing/map_expansion.txt


make_onelocus_tables.pl

  Make the single-locus probability tables

  Input:  Calculations/OnelocusA4/Inputs/pi_k_ind.txt
          Calculations/OnelocusX4/Inputs/pi_k_female.txt
          Calculations/OnelocusX4/Inputs/pi_k_male.txt
          Calculations/OnelocusA4/Inputs/tm.txt
          Calculations/OnelocusX4/Inputs/tm.txt
          Calculations/OnelocusA4/Inputs/nstates.txt
          Calculations/OnelocusA4/Inputs/pi_k_rev.txt
          Calculations/OnelocusX4/Inputs/nstates.txt
          Calculations/OnelocusX4/Inputs/pi_k_rev.txt

  Output: Tables/onelocus_table.tex
          Tables/onelocus_autosome_tm_supp_table.tex
          Tables/onelocus_Xchr_tm_supp_table.tex
          Tables/onelocus_autosome_results_supp_table.tex
          Tables/onelocus_Xchr_results_supp_table.tex


make_selfing_tables.pl

  Make the selfing tables

  Input:  Calculations/Selfing/Inputs/nstates.txt
          Calculations/Selfing/Inputs/tm.txt
          Calculations/Selfing/Inputs/pi_k.txt

  Output: Tables/selfing_table.tex
          Tables/selfing_supp_table.tex


make_twolocus_gen_start_table.pl

  Make the tables with the starting states

  Calculations/TwolociA4/hap_start_rev.txt Calculations/TwolociA4/hap_states.txt -> Tables/hap_autosome_start_supp_table.tex
  Calculations/TwolociX4/female_hap_start_rev.txt Calculations/TwolociX4/female_hap_states.txt -> Tables/hap_Xchr_start_supp_table.tex
  (etc.; see the Makefile)


make_twolocus_gen_table.pl

  Make the two-locus tables

  Calculations/TwolociA4/AA_AA_matrix_alt.txt Calculations/TwolociA4/states_AAAA.txt -> Tables/twolociA4_AA_AA_supp_table.tex
  Calculations/TwolociA4/AA_AB_matrix_rev.txt Calculations/TwolociA4/states_AAAB.txt -> Tables/twolociA4_AA_AB_supp_table.tex
  (etc.; see the Makefile)
