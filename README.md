Designed and implemented a scalable N × N systolic array architecture in Verilog.
Architected the array to support both dense GEMM operations and 2D spatial convolutions using im2col technique.
Verified the RTL functionality using a self-checking testbench


ACHIEVEMENTS:
1. The "Performance" Metric (Throughput)
   A standard CPU performs one or a few Multiply-Accumulate (MAC) operations per clock cycle.    
   A systolic array is designed to do one MAC per PE per cycle (in parallel).The Calculation:CPU: $\approx 2$ to $8$ MACs per cycle. Your Systolic Array: SIZE $\times$ SIZE MACs per cycle.For your $4 \times 4$ array: $4 \times 4 = 16$ MACs per cycle.

    "Achieved a 16x increase in theoretical peak throughput compared to single-issue sequential processing architectures by implementing a parallelized $4 \times 4$ systolic array."


2. The "Efficiency" Metric (Compute-to-Memory)
In a CPU, every time you need to do a multiplication, you have to fetch data from memory, which is slow and power-hungry. Your systolic array passes data between neighboring PEs (spatial reuse).

The Logic: You only fetch each input data point once from main memory. After that, it "ripples" through the array.

"Reduced external memory bandwidth requirements by ~75% through spatial data reuse, enabling high-performance matrix-vector multiplication with minimal energy overhead."


3. The "Latency" Metric (Cycles)
   How long does it take to get the first result compared to a traditional loop?
   The Logic: * A naive software loop for a $4 \times 4$ matrix multiplication takes $N^3$ (64) operations.Your systolic array produces the first result in $2N - 1$ cycles and completes the full block in $3N - 2$ cycles.For $N=4$, that is 10 cycles vs 64 cycles.

   "Minimized computational latency by ~84% (10 cycles vs 64) for $4 \times 4$ matrix operations, achieving near-optimal throughput for real-time inference tasks."
