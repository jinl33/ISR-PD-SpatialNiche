#!/bin/bash
# scripts/fetch_data.sh
mkdir -p data/raw/scrna data/raw/spatial

# Fetch scRNA-seq (GSE202210)
echo "Downloading scRNA-seq data..."
curl -L "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE202nnn/GSE202210/suppl/GSE202210_RAW.tar" -o data/raw/GSE202210_RAW.tar
tar -xvf data/raw/GSE202210_RAW.tar -C data/raw/scrna/

# Fetch Spatial Transcriptomics (GSE253975)
echo "Downloading Xenium/Visium spatial data..."
curl -L "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253975/suppl/GSE253975_RAW.tar" -o data/raw/GSE253975_RAW.tar
tar -xvf data/raw/GSE253975_RAW.tar -C data/raw/spatial/