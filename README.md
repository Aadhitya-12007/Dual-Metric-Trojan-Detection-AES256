# 🔬 Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256

![Research](https://img.shields.io/badge/Research-Hardware_Security-8A2BE2.svg)
![Cipher](https://img.shields.io/badge/Algorithm-AES--256-blue.svg)
![Target](https://img.shields.io/badge/Platform-Xilinx_Versal_VCK5000-orange.svg)
![Published](https://img.shields.io/badge/Published-JTCSST-brightgreen.svg)

> **Official Repository for the publication:** *"Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256: Correlating Power Signatures with Switching Activity"*[cite: 2].

## 📝 Abstract

Hardware Trojans can be accidentally hidden due to synthesis optimizations performed by electronic design automation (EDA) tools in cryptosystems, leaving critical detection gaps[cite: 2]. Traditional detection relies on the assumption that malicious logic increases power consumption[cite: 2]. However, this project demonstrates that EDA optimization can suppress or nullify Trojan signatures, resulting in unexpected **negative power deviations**[cite: 2]. 

This repository introduces a **dual-metric correlation framework** that pairs vector-based power analysis with micro-architectural switching activity distributions (SAIF parsing) to successfully detect synthesis-masked and synthesis-neutralized hardware Trojans[cite: 2].

## 🎯 Key Contributions & Discoveries

*   **Identification of Synthesis Anomalies:** Characterized two distinct EDA interaction failures: *Synthesis-Masked Dormant Trojans* (lower toggles, leftward-shifting distributions) and *Synthesis-Neutralized Active Trojans* (40% more active nets, but lower total power)[cite: 2].
*   **Dual-Metric Detection:** Achieved reproducible structural detection by correlating sub-threshold power deviations (-0.58% to -0.72%) with KL divergence statistics (0.03–0.42) from switching histograms[cite: 2].
*   **Negative Power Signatures:** Demonstrated that 3 out of 4 tested hardware Trojans exhibited negative power deviations, contradicting standard detection assumptions[cite: 2].

## 🧰 Hardware Trojan Threat Models

Four distinct RTL-level hardware Trojans were synthesized into an AES-256 core (NIST FIPS 197 compliant) and evaluated[cite: 2]:

| Trojan | Trigger | Payload | Synthesis Effect | Power Signature | KL Divergence |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **T1** | Rare Sequence | Battery Drain | Neutralized[cite: 2] | -0.67%[cite: 2] | 0.42 (Right Shift)[cite: 2] |
| **T2** | Signal Comparator | LSB Bit Flip | Leakage Bomb[cite: 2] | +110.80%[cite: 2] | 0.03 (Center)[cite: 2] |
| **T3** | Time/Count | LSB Bit Flip | Masked[cite: 2] | -0.72%[cite: 2] | 0.18 (Left Shift)[cite: 2] |
| **T4** | Specific Key | Func. Failure | Masked[cite: 2] | -0.58%[cite: 2] | 0.21 (Left Shift)[cite: 2] |

## ⚙️ Experimental Methodology

1.  **Simulation:** The designs were synthesized targeting the 7nm Xilinx Versal VCK5000 architecture using Vivado 2023.2[cite: 2].
2.  **Test Vectors:** Simulations ran for 10,000 clock cycles (30,000 for T1) across 714 different key/plaintext combinations[cite: 2].
3.  **Data Extraction:** Switching Activity Interchange Format (SAIF) files captured toggle counts across 646 internal nets[cite: 2].
4.  **Analysis:** Post-synthesis vector-based power estimation was correlated with switching distribution histograms generated using Sturges' formula[cite: 2].

## 📂 Repository Structure

*   [`Manuscript/`](Manuscript/) - Final published paper[cite: 2].
*   [`RTL_Source/`](RTL_Source/) - Golden AES-256 and infected Verilog source files[cite: 2].
*   [`Synthesis_Netlists/`](Synthesis_Netlists/) - Post-synthesis netlists for the Versal architecture[cite: 2].
*   [`Simulation_SAIF/`](Simulation_SAIF/) - Extracted switching activity files[cite: 2].
*   [`Power_Reports/`](Power_Reports/) - Vivado vector-based power estimations[cite: 2].
*   [`Scripts/`](Scripts/) - Python algorithms for SAIF parsing and KL divergence computation[cite: 2].

## 📖 Citation

If you use this research or dataset in your work, please cite the original publication[cite: 2]:

```bibtex
@article{rahimunnisa2026dual,
  title={Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256: Correlating Power Signatures with Switching Activity},
  author={Rahimunnisa, K. and Aadhitya, G. and Abhyjeet, J. and Dharnesh, S.},
  journal={Journal of Trends in Computer Science and Smart Technology},
  volume={8},
  issue={2},
  pages={243--266},
  year={2026},
  doi={10.36548/jtcsst.2026.2.003}
}
