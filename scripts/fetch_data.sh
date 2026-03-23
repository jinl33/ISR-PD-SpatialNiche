#!/bin/bash
mkdir -p data/raw/scrna_data/raw/spatial

# Fetch scRNA-seq (GSE202210)
curl -O "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE202nnn/GSE202210/suppl/GSE202210_RAW.tar"
tar -xvf GSE202210_RAW.tar -C data/raw/scrna/

# Fetch Spatial Transcriptomics (GSE253975)
curl -O "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253975/suppl/GSE253975_RAW.tar"
tar -xvf GSE253975_RAW.tar -C data/raw/spatial/
