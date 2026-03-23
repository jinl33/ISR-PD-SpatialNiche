# ISR-PD-SpatialNiche

A high-throughput analytical pipeline to map the **Integrated Stress Response (ISR)** and localized neuroinflammatory niches in the Parkinsonian Substantia Nigra.

## Project Foundation
This project expands upon **Jiang et al. (2025)** by shifting from marker-gene identification to **spatial architecture modeling**. We investigate how activated microglia physically interact with dopaminergic neurons to facilitate disease progression.

* **Hypothesis:** High-ISR microglia exhibit specific ligand-receptor interactions that correlate with localized inflammatory hotspots surrounding neurons.
* **Gene Signature:** We quantify stress using the **129-gene ISR signature (Han et al., 2023)**, a comprehensive record of $eIF2\alpha$-mediated genes verified in human CNS tissue.

---

## High-Throughput Data Strategy
We prioritize anatomical relevance by focusing on the **human Substantia Nigra (SN)** and starting all analyses from **raw count matrices**.

| Dataset | Modality | Platform | Resolution | Observations |
| :--- | :--- | :--- | :--- | :--- |
| **GSE202210** | scRNA-seq | Illumina | N/A | ~60k cells (12 samples) |
| **GSE184950** | Spatial | 10x Genomics Visium | $55~\mu m$ | 10 SN-focused samples |

---

## Engineering Workflow (Nextflow)

1.  **Preprocessing:** Raw QC, ambient RNA removal, and **Harmony-based** batch correction.
2.  **Scoring:** Identifying High vs. Low ISR groups using **AUCell** and a **bimodal distribution threshold**.
3.  **Deconvolution:** Mapping scRNA-seq labels onto Visium spots via **spacexr (RCTD)**.
4.  **Interaction Modeling:** Quantifying signaling probabilities (JAK-STAT, NF-$\kappa$B, Notch) using **CellChat** and **MISTy**.

---

## Setup
### 1. Environment
Standardized versions are managed via Conda to ensure cross-team consistency.
```bash
conda env create -f envs/environment.yml
conda activate pd_isr_env