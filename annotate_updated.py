import os
import glob
import numpy as np
import pandas as pd

filenames = [os.path.basename(x) for x in glob.glob("analysis_raw_results/*.bed")]

metadata = pd.read_table('human_factor_full_QC.txt')

for file in filenames:
    temp_name = os.path.splitext(file)[0]
    df_temp = pd.read_csv("analysis_raw_results/"+str(file),sep="\t",header=None)
    df_temp.columns = ['chromCG','CGstart','CGend','CGid','filename','bed_col_1','bed_col_2','bed_col_3','bed_col_4','bed_col_5','bed_col_6','bed_col_7','bed_col_8','bed_col_9','bed_col_10']
    df_temp["DCid"] = df_temp["filename"].str.replace('human_factor_split/human_factor_[0-9][0-9][0-9]/|_sort_peaks.narrowPeak.bed','').astype('int64')
    df_output = df_temp.merge(metadata, on='DCid', how='left')
    df_output = df_output.sort_values(by=['CGid'])
    df_output.to_csv("analysis_results/" + str(temp_name) + ".csv",index=False)
