setwd('~/BioInf Project/hse21_H3K36me3_ZDNA_human/src')

library(ggplot2)
library(dplyr)
###

NAME <- 'H3K36me3_A549.ENCFF127LEC.hg19'
#NAME <- 'H3K36me3_A549.ENCFF584FSY.hg19'

###
DATA_DIR <- '../data/'
OUT_DIR <- '../img/'

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.init.hist.png'), path = OUT_DIR)

# Remove long peaks
bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 3000)
  
ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.filtered.hist.png'), path = OUT_DIR)

bed_df %>%
  select(-len) %>%
  write.table(file=paste0(DATA_DIR, NAME ,'.filtered.bed'),
            col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)
