library(ggplot2)
library(scales)
theme_set(theme_minimal())

ARramwether <- read.csv("/Users/victoriasugrue/Desktop/ARramwether2.csv") #contains p-values for top 50 asDMPs & information regarding AR binding (from Cistrome database)

positions <- c("DLX1 cg05219494", "FOSB cg10427592", "CASZ1 cg03329528", "TTN cg20683822", "ADAMTS6 cg14411132", "LINC01102 cg13869290", "KIAA2026 cg22489511", "cg13296708", 
               "ZBTB7B cg04627377", "SLMAP cg05072035", "TRPV3 cg20318153", "RBM10 cg26112867", "PRDM6 cg13468491", "NMT1 cg16080654", "cg14319933", "cg22698853", "SLC6A7 cg21349273", 
               "cg12603816", "GAS1 cg03275335", "KCNC2 cg25996664", "SRSF7 cg06959732", "ASXL3 cg20424596",  "IGSF21 cg19124333", "FAM172A cg03032396", "BRINP3 cg24451994", 
               "NOVA1 cg01675333", "MAP2K5 cg08979438", "LINC01235 cg12120400", "RUNX1T1 cg01090134", "SCUBE3 cg12357722", "FN1 cg07158748",  "PHC3 cg20017216",  
               "KCNIP1 cg11035838",  "LINC01894 cg14592546", "CASZ1 cg06145973", "CACNA1I cg06579027", "SRRM2 cg07324453",  "cg09315446",  "BCOR cg18315252", 
               "NOVA1 cg03121178", "LINC01364 cg12863556", "RBM10 cg03197661",  "LINC01364 cg11082332",  "TEX41 cg12129962", "SETD5 cg17489709", "KIAA2026 cg00658920", 
               "LINC01364 cg15851301",  "cg05771328",  "cg01822430", "MKLN1 cg21524116"
)

ggplot(ARramwether, aes(x=name, y=logo10, colour=AR, shape=Intact.male.methylation)) + 
  geom_point(size=3) + 
  scale_x_discrete(limits = positions) + 
  ylab("P-Value (log10)") + 
  xlab ("CpG ID and Gene Name") + 
  scale_y_reverse() + 
  coord_flip() 