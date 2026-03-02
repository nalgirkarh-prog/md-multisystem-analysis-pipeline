# MD-POST: Multi-System GROMACS Post-Processing Pipeline

MD-POST is a modular, multi-system molecular dynamics analysis framework designed for automated post-processing of GROMACS simulations.

It enables:

- Multi-system trajectory preprocessing
- Structural dynamics analysis
- Cross-system statistical comparison
- Comparative visualization
- Automated report generation

---

## 📂 Repository Structure


md_post/
├── config/
│ └── pipeline_config.sh
├── figures/ # Generated figures
├── input/ # User places system folders here
├── LICENSE
├── README.md
├── run_pipeline.sh # Main execution script
└── scripts/
├── 01_preprocess.sh
├── 02_basic_analysis.sh
├── 03_advanced_analysis.sh
├── 04_statistics.R
├── 05_plots.py
├── outputs/ # Auto-generated analysis outputs
└── report_generator.py


---

## 📥 Input Structure

Inside the `input/` directory, create **one folder per system**.

Example:


input/
├── APO/
├── AZA/
├── EUG/
└── DOUBLE/


Each system folder must contain:

- `*.tpr`
- `*.xtc`
- `*.gro`
- `topol.top`
- (optional) `index.ndx`

⚠️ Do not include full GROMACS working directories — only the required files.

---

## ⚙️ Environment Setup

Create and activate a Conda environment:

```bash
conda create -n md_pipeline python=3.10 r-base
conda activate md_pipeline

conda install -c conda-forge gromacs r-tidyverse r-rstatix
pip install pandas matplotlib seaborn
▶️ Running the Pipeline
Run Full Workflow
./run_pipeline.sh

This will:

Detect all systems in input/

Preprocess trajectories

Perform structural analyses

Execute statistical comparison

Generate comparative plots

Create a consolidated report

Run Statistics & Report Only

If trajectory analysis is already completed:

./run_pipeline.sh stats
📊 Analyses Performed

Per system:

RMSD

RMSF

Radius of Gyration (Rg)

SASA

Hydrogen Bonds

PCA (if enabled)

Cross-system:

Kruskal–Wallis statistical testing

Boxplots & violin plots

Summary statistics comparison

📈 Output Locations

Analysis results:

scripts/outputs/

Generated figures:

figures/

Final report:

scripts/outputs/final_report/analysis_report.txt
🧪 Statistical Methodology

Non-parametric Kruskal–Wallis test

Significance threshold: p < 0.05

🔬 Design Principles

Multi-system scalable

Modular architecture

Reproducible workflow

Separation of preprocessing, analysis, statistics, and reporting

Publication-ready outputs

📜 License

This project is licensed under the MIT License.

---

## 📚 Citation

If you use this pipeline in your research, please cite:

**Harsh (2026).**  
*MD-POST: Multi-System GROMACS Post-Processing Pipeline.*  
GitHub repository.  

Available at: https://github.com/<your-username>/md-post  
Version: v1.0

### BibTeX

```bibtex
@software{mdpost2026,
  author  = {Harsh},
  title   = {MD-POST: Multi-System GROMACS Post-Processing Pipeline},
  year    = {2026},
  url     = {(https://github.com/nalgirkarh-prog/md-multisystem-analysis-pipeline/edit/main/md_post)},
  version = {v1.0}
}
