## Workshop script.


# Read in fold change and FDR values from day comparisons of MG tissues into a table
D.MG.FA_table.FC.FDR <- read.table("D.MG.FA_table.FC.FDR.txt", header = TRUE)

# Find the rows with significant FDR (<0.05) in a least 1 comparison
sig.genes <- D.MG.FA_table.FC.FDR$D65.E.MG.FDR < 0.05 |
	D.MG.FA_table.FC.FDR$D100.E.MG.FDR < 0.05 |
	D.MG.FA_table.FC.FDR$D65.C.MG.FDR < 0.05 |
	D.MG.FA_table.FC.FDR$D100.C.MG.FDR < 0.05

# Extract from the table only significant genes and logFC columns to create a table of fold changes
FC <- D.MG.FA_table.FC.FDR[sig.genes, c("gene_id", "D65.E.MG.logFC", "D100.E.MG.logFC", "D65.C.MG.logFC", "D100.C.MG.logFC")]

# Merge FC and gene.kegg.ids tables by gene_id
FC <- merge(gene.kegg.ids, FC, by = "gene_id")

# Sum FC values for salmon genes with the same Dre id
FC.kegg_gareth <- aggregate(. ~  kegg.genes, data = FC[,c(2,4:7)], sum)
FC.kegg <- group_by(FC, kegg.genes) %>%
	summarise(sumD65.mariene = sum(D65.E.MG.logFC),
				 sumD100.marine = sum(D100.E.MG.logFC),
				 sumD65.veg = sum(D65.C.MG.logFC),
				 sumD100.veg = sum(D100.C.MG.logFC)
	)
