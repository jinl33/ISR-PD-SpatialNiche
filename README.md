# ISR-PD-SpatialNiche

A high-throughput analytical pipeline to map the **Integrated Stress Response (ISR)** and localized neuroinflammatory niches in the Parkinsonian Substantia Nigra.

## Project Foundation
This project expands upon **[Jiang et al. (2025)](https://doi.org/10.2147/JIR.S521744)** by shifting from marker-gene identification to **spatial architecture modeling**. We investigate how activated microglia physically interact with dopaminergic neurons to facilitate disease progression.

* **Hypothesis:** High-ISR microglia exhibit specific ligand-receptor interactions that correlate with localized inflammatory hotspots surrounding neurons.
* **Gene Signature:** We quantify stress using the **129-gene ISR signature (Han et al., 2023; Ref #40 in Jiang et al. (2025))**, a comprehensive record of $eIF2\alpha$-mediated genes verified in human CNS tissue.

---

## Data Strategy
We prioritize anatomical relevance by focusing on the **human Substantia Nigra (SN)** and starting all analyses from **raw count matrices**.

| Dataset | Modality | Platform | Resolution | Observations |
| :--- | :--- | :--- | :--- | :--- |
| **GSE202210** | snRNA-seq | 10x Genomics Chromium | single nucleus | ~207k nuclei (28 donors) |
| **GSE253975** | Spatial transcriptomics | 10x Genomics Xenium In Situ + 10x Genomics Visium | Subcellular + $55~\mu m$ | 10 PD and 8 control donors |

---

## Data Acquisition
To ensure consistency, use the provided automated script to fetch raw data.

### 1. Requirements
Ensure `curl` and `tar` are installed. For raw sequence (FASTQ) access, ensure `sra-tools` is in your path.

### 2. Extraction Commands
A utility script is provided in `scripts/fetch_data.sh`.

```bash
#!/bin/bash
# scripts/fetch_data.sh
mkdir -p data/raw/snrna_ref data/raw/spatial

# Fetch snRNA-seq (GSE253462)
curl -O "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253462/suppl/GSE253462_RAW.tar"
tar -xvf GSE253462.tar -C data/raw/snrna_ref/

# Fetch Spatial Transcriptomics (GSE253975)
curl -O "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE253nnn/GSE253975/suppl/GSE253975_RAW.tar"
tar -xvf GSE253975_RAW.tar -C data/raw/spatial/
```

## Engineering Workflow (Nextflow)
Our pipeline is built for reproducibility to manage the "ambitious" multi-modal integration:

1. **High-Throughput Preprocessing:** Raw QC, ambient RNA removal, and Harmony-based batch correction to harmonize the 59,621 cells while preserving biological variance.
2. **ISR Signature Scoring:** Quantifying stress via AUCell. "High" vs. "Low" ISR groups are identified using a bimodal distribution threshold for statistical rigor over arbitrary cutoffs.
3. **Spatial Resolution Mapping:** Using 10x Genomics Xenium In Situ and Visium to validate whether high-ISR microglial signatures are physically adjacent to degenerating dopaminergic neurons at subcellular and $55~\mu m$ spot resolution.
4. **Interaction Modeling:** Modeling signaling probabilities (JAK-STAT, NF-$\kappa$B, Notch) using CellChat and MISTy as a function of physical cellular proximity, including T-cell and glial interactions.

## Setup

### 1. Environment Configuration
Standardized versions are managed via Conda to ensure cross-team consistency.

```yaml
name: venv
channels:
	- conda-forge
	- bioconda
	- defaults
dependencies:
	- python=3.10
	- r-base=4.3
	- scanpy
	- python-annoy
	- r-seurat
	- r-harmony
	- r-glmnet
	- r-randomforest
	- bioconda::bioconductor-aucell
	- bioconda::bioconductor-spacexr
	- bioconda::sra-tools
	- pip
	- pip:
		- cellchat
		- misty
```

Create the environment with:

```bash
conda env create -f envs/environment.yml
conda activate venv
```

### 2. Directory Structure

```text
pd-isr-niche/
├── data/
│   ├── raw/           # Original GEO supplementary downloads (Git ignored)
│   └── processed/     # Harmony-corrected Seurat/Scanpy objects
├── envs/              # environment.yml
├── notebooks/         # Author-specific exploratory analysis (EDA)
├── pipelines/         # Nextflow workflow logic (.nf)
├── scripts/           # Modular R/Python helper scripts
└── results/           # Figures and signaling tables
```

### 3. Git Workflow
To keep the main branch stable, please use a feature-branch workflow:

```bash
git checkout -b feature/your-task-name
git commit -m "Brief description of update"
git push
```