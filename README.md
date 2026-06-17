# Parameterized Systolic Array Architecture

## Overview

A scalable **N × N systolic array architecture** implemented in Verilog, optimized for high-throughput **matrix-matrix multiplication (GEMM)** and **CNN inference**. This project bridges the gap between spatial hardware design and efficient deep learning acceleration using the **im2col** technique.

---

## Key Features

### Scalable Architecture
- Parameterized **N × N** design.
- Optimized for resource efficiency and scalability across different array sizes.

### Dual-Purpose Compute Engine
- Supports standard dense **GEMM (General Matrix Multiplication)**.
- Supports **2D spatial convolutions** through **im2col preprocessing**, enabling CNN acceleration using the same hardware datapath.

### Verification
- Rigorous validation using a self-checking testbench.
- Ensures mathematical correctness across varying matrix dimensions and input patterns.

---

## Performance Benchmarks

Comparison against a standard single-issue sequential processing baseline for a **4 × 4 matrix multiplication**.

| Metric | Result | Impact |
|---------|---------|---------|
| Throughput | **16× peak improvement** | Parallelized MAC operations across N² processing elements |
| Latency | **3N − 2 cycles** | Significantly lower than the **N³** operations required by a sequential implementation |
| Efficiency | **Reduced memory bandwidth demand** | Spatial data reuse through local PE interconnects |

---

## Architecture

The accelerator consists of an interconnected grid of Processing Elements (PEs), where:

- Input activations propagate horizontally.
- Weights propagate vertically.
- Partial sums are accumulated locally.
- Data reuse minimizes external memory accesses.

This spatial computing paradigm enables high throughput while maintaining efficient hardware utilization.

---

## Applications

- Matrix Multiplication (GEMM)
- CNN convolutions
- AI Acceleration


---

## Technologies Used

- **Verilog HDL**
- **Systolic Array Architecture**
- **im2col Transformation**
- **Self-Checking Testbench Verification**

---


## Author

**Sai Krishna M.**

Electrical Engineering, IIT Indore
