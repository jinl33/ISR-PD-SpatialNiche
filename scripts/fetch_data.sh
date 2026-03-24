#!/bin/bash
# scripts/fetch_data.sh
# GSE253975: Spatiotranscriptomics data (Visium + Xenium In Situ)
# GSE253462: snRNAseq reference (same cohort - required for ISR signature definition)

mkdir -p data/raw/spatial/{visium,xenium} data/raw/snrna_ref

# Fetch Spatial Transcriptomics (GSE253975) - PRIMARY DATASET
echo "Downloading Spatial Transcriptomics (GSE253975)..."
echo "  - 10x Visium (55 μm resolution, 10 samples)"
echo "  - 10x Xenium In Situ (subcellular resolution, 10 samples)"
curl -L "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253975/suppl/GSE253975_RAW.tar" \
  -o data/raw/GSE253975_RAW.tar

if [ -f data/raw/GSE253975_RAW.tar ]; then
  tar -xvf data/raw/GSE253975_RAW.tar -C data/raw/spatial/
  mv data/raw/spatial/*.json.gz data/raw/spatial/visium/ 2>/dev/null
  mv data/raw/spatial/*.txt.gz data/raw/spatial/xenium/ 2>/dev/null
  echo "✓ Spatial data organized (visium/ and xenium/ subdirectories)"
fi

# Fetch snRNAseq Reference (GSE253462) - REFERENCE FOR ISR SIGNATURE DEFINITION
echo ""
echo "Downloading snRNAseq Reference (GSE253462)..."
echo "  - 13 PD + 15 control nuclei from Substantia Nigra"
echo "  - 10 PD + 8 control nuclei from Cingulate cortex"
echo "  - Total: ~265,000 nuclei with cell type annotations"
curl -L "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253462/suppl/GSE253462_RAW.tar" \
  -o data/raw/GSE253462_RAW.tar

if [ -f data/raw/GSE253462_RAW.tar ]; then
  tar -xvf data/raw/GSE253462_RAW.tar -C data/raw/snrna_ref/
  echo "✓ snRNAseq reference downloaded to data/raw/snrna_ref/"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║ Data Download Complete                                         ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║ Expected directory structure:                                   ║"
echo "║   data/raw/spatial/visium/         (10 samples, Visium JSON)   ║"
echo "║   data/raw/spatial/xenium/         (10 samples, Xenium TXT)    ║"
echo "║   data/raw/snrna_ref/              (snRNAseq counts + metadata)║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "✓ Ready for analysis. See analysis/output/DATASET_ASSESSMENT_REPORT.md"