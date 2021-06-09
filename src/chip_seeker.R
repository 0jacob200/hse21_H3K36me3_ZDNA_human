setwd('~/BioInf Project/hse21_H3K36me3_ZDNA_human/src')

###
#install.packages("ggplot2")
#install.packages(dplyr)
#install.packages(tidyr)
#install.packages(tibble)
#install.packages(ChIPseeker)
#install.packages(TxDb.Hsapiens.UCSC.hg19.knownGene)
#(clusterProfiler)

library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)

# Installing BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ChIPseeker", force=TRUE)
nBiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", force=TRUE)
BiocManager::install("clusterProfiler", force=TRUE)
BiocManager::install("GenomicFeatures", force=TRUE)
BiocManager::install("org.Hs.eg.db", force=TRUE)
BiocManager::install("ChIPpeakAnno", force=TRUE)


library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)
library(org.Hs.eg.db)

###
DATA_DIR <- '../data/'
OUT_DIR <- '../img/'
#NAME <- 'H3K4me3_A549.intersect_with_DeepZ'
#NAME <- 'DeepZ'
NAME <- 'H3K36me3_A549.ENCFF127LEC.hg19.filtered'
#NAME <- 'H3K36me3_A549.ENCFF584FSY.hg19.filtered'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(readPeakFile(BED_FN), tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

# peak <- readPeakFile(BED_FN)
# pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
# covplot(peak, weightCol="V5")
# dev.off()
# 


