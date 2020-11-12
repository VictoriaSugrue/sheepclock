# sheepclock
Scripts for sheep epigenetic clock/castration project


12 November 2020

annotate_updated.py 
- Python script. Annotates the intersects found in “intersect_updated.sd” with the transcription factor and experiment information (Cistrome analysis)
	
arrayNormalizationTutorialVersion2.Rmd
- R script. Minfi normalization with noob background correction

Fig1B_Manhattan.R
- R script. Manhattan plot of all probes x p-value of age correlation using qqman package

Fig2_SheepClocks.R
- R script. Plots chronological age against DNAm age for each iteration of the sheep/sheep+human epigenetic clock (Figs 2A-G)

Fig3_AgeAccelandAgeDep.R
- R script. Age dependency and age acceleration for mature sheep ear (Age dependency Figs 3A, Supplementary Fig 1B; Age acceleration Figs 3B, Supplementary Figs 1A, 3)

Fig4_asDMPs.R
- R script. Methylation levels of selected androgen-sensitive differentially methylation probes with chronological age (Figs 4A-D)  

Fig5A_asDMPpvalue_ARbinding.R
- R script. Plots the top 50 androgen-sensitive differentially methylated probes based on p-value and androgen receptor binding (Fig 5A)

Fig5B_CistromeObservedExpected.R
- R script. Plots observed levels of TF binding (based on top 50 asDMPs) against expected levels of TF binding (Fig 5B)

FigS2B_GlobalMethylation.R
- R script. Mean global methylation levels across all probes for each individual sample (Supplementary Fig 2B)

FigS4A_InflectionPointasDMP.R
- R script. Plots p-values of androgen-sensitive differentially methylated probes (Supplementary Fig 4A)

FigS6_LambMass.R
- R script. Calculates and plots mean + SEM of male lamb weights (Supplementary Fig 6)

intersect_updated.sh
- Bash script. Finds intersects between queries and each one of the ChIP-seq BED files (Cistrome analysis)

MannWhitney_AgeAccel.R
- R script. Calculates p-values for difference in epigenetic age acceleration between two groups (Mann-Whitney U test) 

ReadingInMinfiFile.R
- R script. Reads in minfi normalized beta value file, plot for looking at single CpGs (e.g. Figs 1C-D, 6A-B), subsets into tissue/sex groups

WGCNAcorrelation.R
- R script. Uses weighted correlation network analysis (WGCNA) to calculate the correlation between probe methylation and chronological age
