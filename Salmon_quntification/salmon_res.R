setwd("~tikn/SeqData3/rna-seq-SMC/4-sample_pilot_project/salmon_quantification")
require("readr")
require("dplyr")


# Make array file for cluster  --------------------------------------------
# files_list <- list.files(full.names = T, recursive = F, path = "~tikn/SeqData3/rna-seq-SMC//4-sample_pilot_project/fastq_trimPE/")
# files_list <- data.frame(matrix(files_list, nrow = 4, byrow = T))
# files_list <- mutate(files_list, sample = str_extract(X1, "S[\\d]{1}"))
# write_delim(files_list, path = "array_file.txt", col_names = F)


# Read in results ---------------------------------------------------------
sf_files <- list.files(".", pattern = ".sf", recursive = T, full.names = T)

read_f <- function(x){
	df <- read_delim(x, delim = "\t")
	Sample <- str_extract(x, "S[0-9]{1}")
	df <- mutate(df, Sample = Sample)
}
df <- ldply(sf_files, .fun = read_f, .progress = "text")
df <- mutate(df, name2_join = str_replace(Name, "\\..$","" ))


# Add annotation from NCBI ------------------------------------------------
library(org.Bt.eg.db)
enseml_2_ncbi <- toTable(org.Bt.egENSEMBLTRANS2EG)
ncbi2_gene_name <- toTable(org.Bt.egGENENAME)

df_full <- inner_join(df, enseml_2_ncbi, by = c("name2_join" = "trans_id")) %>%
	tbl_df %>%
	inner_join(ncbi2_gene_name, by = c("gene_id"))

## Get GO terms for the genes.
go <- toTable(org.Bt.egGO2EG)

## Check top expressed genes. Seem to come from white blood cells.
with_go_terms_s1 <- filter(df_full,Sample == "S1") %>%
	arrange(desc(TPM)) %>%
	inner_join(go) %>% filter(TPM > 500)

## Write out the unique gene IDs and use geneontoloy.org 
write(unique(with_go_terms_s1$gene_id))






