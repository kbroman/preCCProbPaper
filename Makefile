pdf: preCCprob.pdf preCCprob_supp.pdf preCCprob_combined.pdf Revised/response.pdf

preCCprob_combined.pdf: preCCprob.pdf preCCprob_supp.pdf
	combinepdf -f preCCprob.pdf preCCprob_supp.pdf preCCprob_combined.pdf

Revised/response.pdf: Revised/response.tex
	cd Revised;pdflatex response

preCCprob.pdf: preCCprob.tex preCCprob.bib genetics.bst Makefile Figs/fixation_time.eps Figs/rifig.eps Figs/map_expansion.eps
	xelatex preCCprob
	bibtex preCCprob
	xelatex preCCprob
	xelatex preCCprob
	xelatex preCCprob

preCCprob_supp.pdf: preCCprob_supp.tex genetics.bst Makefile Figs/onelocus_fig.eps Figs/happrob_fig.eps Figs/riXfig.eps 
	xelatex preCCprob_supp

preCCprob.tex: preCCprob_notab.tex Makefile Tables/selfing_table.tex Tables/onelocus_table.tex Tables/fixation_table.tex Tables/haplotype_table.tex Tables/map_expansion_table.tex
	Perl/insert_tables.pl preCCprob_notab.tex

preCCprob_supp.tex: preCCprob_supp_notab.tex Makefile Tables/selfing_table.tex Tables/twolociA4_AA_AA_supp_table.tex Tables/twolociX4_female_AA_AA_supp_table.tex Tables/twolociA4_AA_AB_supp_table.tex Tables/twolociX4_female_AA_AB_supp_table.tex Tables/twolociA4_AA_BB_supp_table.tex Tables/twolociX4_female_AA_BB_supp_table.tex Tables/twolociA4_AA_AA_start_supp_table.tex Tables/twolociX4_female_AA_AA_start_supp_table.tex Tables/twolociA4_AA_AB_start_supp_table.tex Tables/twolociX4_female_AA_AB_start_supp_table.tex Tables/twolociA4_AA_BB_start_supp_table.tex Tables/twolociX4_female_AA_BB_start_supp_table.tex Tables/onelocus_autosome_tm_supp_table.tex Tables/onelocus_Xchr_tm_supp_table.tex Tables/onelocus_autosome_results_supp_table.tex Tables/onelocus_Xchr_results_supp_table.tex Tables/hap_autosome_tm_supp_table.tex Tables/hap_Xchr_tm_supp_table.tex Tables/hap_autosome_start_supp_table.tex Tables/hap_Xchr_start_supp_table.tex Figs/onelocus_fig.eps Figs/happrob_fig.eps Figs/riXfig.eps Tables/statesA8_supp_table.tex Tables/statesX8_supp_table.tex
	Perl/insert_tables.pl preCCprob_supp_notab.tex

Tables/selfing_table.tex: Calculations/Selfing/Inputs/nstates.txt Calculations/Selfing/Inputs/pi_k.txt Perl/make_selfing_tables.pl
	Perl/make_selfing_tables.pl

Tables/map_expansion_table.tex: Calculations/Selfing/Inputs/map_expansion.txt Calculations/TwolociA4/map_expansion.txt Calculations/TwolociX4/map_expansion.txt Perl/make_map_expansion_table.pl
	Perl/make_map_expansion_table.pl

Tables/haplotype_table.tex: Calculations/TwolociA4/hap_rev.txt Calculations/TwolociX4/female_hap_rev.txt Calculations/TwolociX4/male_hap_rev.txt Perl/make_hap_tables.pl
	Perl/make_hap_tables.pl

Tables/onelocus_table.tex: Calculations/OnelocusA4/Inputs/pi_k_ind.txt Calculations/OnelocusX4/Inputs/pi_k_female.txt Calculations/OnelocusX4/Inputs/pi_k_male.txt Perl/make_onelocus_tables.pl
	Perl/make_onelocus_tables.pl

Tables/onelocus_autosome_tm_supp_table.tex: Calculations/OnelocusA4/Inputs/tm.txt
	Perl/make_onelocus_tables.pl

Tables/onelocus_Xchr_tm_supp_table.tex: Calculations/OnelocusX4/Inputs/tm.txt
	Perl/make_onelocus_tables.pl

Tables/onelocus_autosome_results_supp_table.tex: Calculations/OnelocusA4/Inputs/pi_k_rev.txt Calculations/OnelocusA4/Inputs/nstates.txt
	Perl/make_onelocus_tables.pl

Tables/onelocus_Xchr_results_supp_table.tex: Calculations/OnelocusX4/Inputs/pi_k_rev.txt Calculations/OnelocusX4/Inputs/nstates.txt
	Perl/make_onelocus_tables.pl

Tables/fixation_table.tex: Calculations/OnelocusA4/Inputs/fixation.txt Calculations/OnelocusX4/Inputs/fixation.txt Perl/make_fixation_table.pl
	Perl/make_fixation_table.pl

Tables/hap_autosome_tm_supp_table.tex: Calculations/TwolociA4/hap_matrix.txt Calculations/TwolociA4/hap_states.txt Perl/make_hap_tm_table.pl
	Perl/make_hap_tm_table.pl Calculations/TwolociA4/hap_matrix.txt Calculations/TwolociA4/hap_states.txt Tables/hap_autosome_tm_supp_table.tex

Tables/hap_autosome_start_supp_table.tex: Calculations/TwolociA4/hap_start_rev.txt Calculations/TwolociA4/hap_states.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociA4/hap_start_rev.txt Calculations/TwolociA4/hap_states.txt Tables/hap_autosome_start_supp_table.tex

Tables/hap_Xchr_tm_supp_table.tex: Calculations/TwolociX4/female_hap_matrix.txt Calculations/TwolociX4/female_hap_states.txt Perl/make_hap_tm_table.pl
	Perl/make_hap_tm_table.pl Calculations/TwolociX4/female_hap_matrix.txt Calculations/TwolociX4/female_hap_states.txt Tables/hap_Xchr_tm_supp_table.tex

Tables/hap_Xchr_start_supp_table.tex: Calculations/TwolociX4/female_hap_start_rev.txt Calculations/TwolociX4/female_hap_states.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociX4/female_hap_start_rev.txt Calculations/TwolociX4/female_hap_states.txt Tables/hap_Xchr_start_supp_table.tex

Tables/twolociA4_AA_AA_supp_table.tex: Calculations/TwolociA4/AA_AA_matrix_alt.txt Calculations/TwolociA4/states_AAAA.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociA4/AA_AA_matrix_alt.txt Calculations/TwolociA4/states_AAAA.txt Tables/twolociA4_AA_AA_supp_table.tex

Tables/twolociA4_AA_AB_supp_table.tex: Calculations/TwolociA4/AA_AB_matrix_rev.txt Calculations/TwolociA4/states_AAAB.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociA4/AA_AB_matrix_rev.txt Calculations/TwolociA4/states_AAAB.txt Tables/twolociA4_AA_AB_supp_table.tex

Tables/twolociA4_AA_BB_supp_table.tex: Calculations/TwolociA4/AA_BB_matrix.txt Calculations/TwolociA4/states_AABB.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociA4/AA_BB_matrix.txt Calculations/TwolociA4/states_AABB.txt Tables/twolociA4_AA_BB_supp_table.tex

Tables/twolociX4_female_AA_AA_supp_table.tex: Calculations/TwolociX4/female_AA_AA_matrix_alt.txt Calculations/TwolociX4/female_states_AAAA.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociX4/female_AA_AA_matrix_alt.txt Calculations/TwolociX4/female_states_AAAA.txt Tables/twolociX4_female_AA_AA_supp_table.tex

Tables/twolociX4_female_AA_AB_supp_table.tex: Calculations/TwolociX4/female_AA_AB_matrix_rev2.txt Calculations/TwolociX4/female_states_AAAB.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociX4/female_AA_AB_matrix_rev2.txt Calculations/TwolociX4/female_states_AAAB.txt Tables/twolociX4_female_AA_AB_supp_table.tex

Tables/twolociX4_female_AA_BB_supp_table.tex: Calculations/TwolociX4/female_AA_BB_matrix_alt.txt Calculations/TwolociX4/female_states_AABB.txt Perl/make_twolocus_gen_table.pl
	Perl/make_twolocus_gen_table.pl Calculations/TwolociX4/female_AA_BB_matrix_alt.txt Calculations/TwolociX4/female_states_AABB.txt Tables/twolociX4_female_AA_BB_supp_table.tex

Tables/twolociA4_AA_AA_start_supp_table.tex: Calculations/TwolociA4/AA_AA_start.txt Calculations/TwolociA4/states_AAAA.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociA4/AA_AA_start.txt Calculations/TwolociA4/states_AAAA.txt Tables/twolociA4_AA_AA_start_supp_table.tex

Tables/twolociA4_AA_AB_start_supp_table.tex: Calculations/TwolociA4/AA_AB_start_rev.txt Calculations/TwolociA4/states_AAAB.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociA4/AA_AB_start_rev.txt Calculations/TwolociA4/states_AAAB.txt Tables/twolociA4_AA_AB_start_supp_table.tex

Tables/twolociA4_AA_BB_start_supp_table.tex: Calculations/TwolociA4/AA_BB_start.txt Calculations/TwolociA4/states_AABB.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociA4/AA_BB_start.txt Calculations/TwolociA4/states_AABB.txt Tables/twolociA4_AA_BB_start_supp_table.tex

Tables/twolociX4_female_AA_AA_start_supp_table.tex: Calculations/TwolociX4/female_AA_AA_start.txt Calculations/TwolociX4/female_states_AAAA.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociX4/female_AA_AA_start.txt Calculations/TwolociX4/female_states_AAAA.txt Tables/twolociX4_female_AA_AA_start_supp_table.tex

Tables/twolociX4_female_AA_AB_start_supp_table.tex: Calculations/TwolociX4/female_AA_AB_start_rev2.txt Calculations/TwolociX4/female_states_AAAB.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociX4/female_AA_AB_start_rev2.txt Calculations/TwolociX4/female_states_AAAB.txt Tables/twolociX4_female_AA_AB_start_supp_table.tex

Tables/twolociX4_female_AA_BB_start_supp_table.tex: Calculations/TwolociX4/female_AA_BB_start.txt Calculations/TwolociX4/female_states_AABB.txt Perl/make_twolocus_gen_start_table.pl
	Perl/make_twolocus_gen_start_table.pl Calculations/TwolociX4/female_AA_BB_start.txt Calculations/TwolociX4/female_states_AABB.txt Tables/twolociX4_female_AA_BB_start_supp_table.tex

Figs/fixation_time.eps: R/fixation_time.R
	cd R;R CMD BATCH fixation_time.R

Figs/rifig.eps: R/rifig.R R/rifig_func.R
	cd R;R CMD BATCH rifig.R

Figs/riXfig.eps: R/riXfig.R R/rifig_func.R
	cd R;R CMD BATCH riXfig.R

Figs/onelocus_fig.eps: R/onelocus_fig.R Calculations/OnelocusA4/R/onelocusA4.R Calculations/OnelocusX4/R/onelocusX4.R
	cd R;R CMD BATCH onelocus_fig.R

Figs/happrob_fig.eps: R/happrob_fig.R Calculations/TwolociA4/R/hap.R Calculations/TwolociX4/R/female_hap.R Calculations/TwolociX4/R/male_hap.R
	cd R;R CMD BATCH happrob_fig.R

Tables/statesA8_supp_table.tex: Calculations/Eightway/statesA8_rev.txt Perl/make_8w_state_supp_tables.pl
	Perl/make_8w_state_supp_tables.pl Calculations/Eightway/statesA8_rev.txt Tables/statesA8_supp_table.tex

Tables/statesX8_supp_table.tex: Calculations/Eightway/statesX8_rev.txt Perl/make_8w_state_supp_tables.pl
	Perl/make_8w_state_supp_tables.pl Calculations/Eightway/statesX8_rev.txt Tables/statesX8_supp_table.tex

R/map_expansion_func.R: Calculations/Selfing/Inputs/map_expansion.txt Calculations/TwolociA4/map_expansion.txt Calculations/TwolociX4/map_expansion.txt Perl/make_map_expansion_table.pl
	Perl/make_map_expansion_table.pl

Figs/map_expansion.eps: R/map_expansion_func.R R/map_expansion_fig.R
	cd R;R CMD BATCH map_expansion_fig.R


clean: 
	\rm -f *.aux *.bbl *.blg *.log *.bak *~ *.Rout */*~ */*.Rout */*.aux */*.log

cleanall: 
	\rm -f *.aux *.bbl *.blg *.log *.pdf *.bak *~ *.Rout */*~ */*.Rout */*.pdf */*.aux */*.log
