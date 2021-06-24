# sheepclock

This data and code relates to the publication; Sugrue et al. eLife 2021;10:e64932, entitled Castration delays epigenetic aging and feminizes DNA methylation at androgen-regulated loci (https://doi.org/10.7554/eLife.64932)

Updated 18 June 2021

annotate_updated.py 
- Python script. Annotates the intersects found in “intersect_updated.sd” with the transcription factor and experiment information (Cistrome analysis)
	
arrayNormalizationTutorialVersion2.Rmd
- R script. Minfi normalization with noob background correction

CistromeBackgroundTFcounts.R
 R script. Calculates the expected background levels of TF binding from 1000 x 50 replicates, Cistrome database 

Fig1B_ManhattanPlot.R
- R script. Manhattan plot of all probes x p-value of age correlation using qqman package

Fig1CD_BioSites.R
- R script. Plots methylation against age for biologically relevant sites: IGF1, FGF8, PAX5/6, HOXC4

Fig2_SheepClocks.R
- R script. Plots chronological age against DNAm age for each iteration of the sheep/sheep+human epigenetic clock (Figs 2A-G)

Fig3_AgeAccelandAgeDep.R
- R script. Age dependency and age acceleration for mature sheep ear (Age dependency Figs 3A, Supplementary Fig 1B; Age acceleration Figs 3B, Supplementary Figs 1A, 3)

Fig4_asDMPs.R
- R script. Methylation levels of selected androgen-sensitive differentially methylation probes with chronological age (Figs 4A-D)  

Fig5A_asDMPpvalue_ARbinding.R
- R script. Plots the top 50 androgen-sensitive differentially methylated probes based on p-value and androgen receptor binding (Fig 5A)

Fig5B_FigS4CD_OECalulations_asDMP_Cistrome.R
- R script. Observed levels of TF binding (based on top 50 asDMPs) against expected levels of TF binding (Fig 5B). Observed over expected ratios for AR (Fig S4C) and NR3C1 (Fig S4D) by windows of 50 asDMPs

Fig6_MouseTissues_ARExpression.R
- R script. Methylation levels in different tissues of male and female mice (Fig 6A-C)

FigS2B_GlobalMethylation.R
- R script. Mean global methylation levels across all probes for each individual sample (Supplementary Fig 2B)

FigS4B_InflectionPointasDMP.R
- R script. Plots p-values of androgen-sensitive differentially methylated probes (Supplementary Fig 4A)

FigS6_LambMass.R
- R script. Calculates and plots mean + SEM of male lamb weights (Supplementary Fig 6)

FigS6BC_CastrationMass.R
- R script. Association between mass and methylation in rams compared with wethers (Fig S6B); Ordered asDMP significance values (Fig S6C)

Fig7_MKLN1_Bat.R
- R script. MKLN1 (cg21524116) methylation levels in male and female bats of different species 

MASTER_Betas_Minfi_Normalised_[x].csv.zip
- .csv files. Raw data of methylation at all probes. Split into 4 files

intersect_updated.sh
- Bash script. Finds intersects between queries and each one of the ChIP-seq BED files (Cistrome analysis)

MannWhitney_AgeAccel.R
- R script. Calculates p-values for difference in epigenetic age acceleration between two groups (Mann-Whitney U test) 

ReadingInMinfiFile.R
- R script. Reads in minfi normalized beta value file, plot for looking at single CpGs, subsets into tissue/sex groups

SampleSheetAgeN18Version5.csv
- .csv file. Sample sheet for sheep experiments 

WGCNAcorrelation.R
- R script. Uses weighted correlation network analysis (WGCNA) to calculate the correlation between probe methylation and chronological age

YoungRamWetherInfo_DNAQuantEtc.csv
- .csv file. Details mass (weight) of lambs (<0.55 years) 

datPredictedAgeN18FinalJosephZoller.csv
- .csv file. Details estimated DNAm age and age acceleration for sheep clock (trained in blood and ear)

human_factor_full_QC.txt
- .txt file. Cistrome metadata file
