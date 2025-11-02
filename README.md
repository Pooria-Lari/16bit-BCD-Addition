# BCD Addition Algorithm (8086 Assembly → Pseudocode)

This pseudocode represents the logic of a **Binary-Coded Decimal (BCD) addition** algorithm,  
originally implemented in **8086 Assembly**.  
The algorithm adds two 16-bit numbers in BCD format and corrects digits greater than 9.

---

## Pseudocode

```text
BCD_ADD(A, B)
1    Initialize AX ← 0, CX ← 0
2    REPORT ← 0
3    RESULT_BITS ← 0         // Check Carry in X000H with CF
4    LOOP:
5        BX ← A              // First 16-bit BCD number
6        DX ← B              // Second 16-bit BCD number
7        BX ← BX + DX        // Perform initial addition
8        if CL == 0 then
9            goto CHECK_000XH
10       else if CL == 1 then
11           goto CHECK_00X0H
12       else if CL == 2 then
13           goto CHECK_0X00H
14       else if CL == 3 then
15           goto CHECK_X000H
16       end if
17       AH ← AH AND 1H
18       REPORT ← REPORT OR AH
19       AH ← CH
20       RESULT_BITS ← AX
21       goto END_PROCESS
--------------------------------------------------
CHECK_000XH:
22   CL ← 1
23   BX ← BX AND 000FH         // isolate least-significant nibble 24   if BX > 0009H then
25       BX ← BX + 0006H       // add 6 for BCD correction 26       BX ← BX AND 001FH
27       AL ← AL + BL
28       goto LOOP
29   else
30       AL ← AL + BL
31       goto LOOP
32   end if
--------------------------------------------------
CHECK_00X0H:
33   CL ← 2
34   BX ← BX AND 00F0H        // isolate second nibble
35   if BX > 0090H then
36       BX ← BX + 0060H
37       BX ← BX AND 01F0H
38       AL ← AL + BL
39       CH ← CH + BH
40       goto LOOP
41   else
42       AL ← AL + BL
43       goto LOOP
44   end if
--------------------------------------------------
CHECK_0X00H:
45   CL ← 3
46   BX ← BX AND 0F00H        // isolate third nibble
47   if BX > 0900H then
48       BX ← BX + 0600H
49       BX ← BX AND 1F00H
50       CH ← CH + BH
51       goto LOOP
52   else
53       CH ← CH + BH
54       goto LOOP
55   end if
--------------------------------------------------
CHECK_X000H:
56   CL ← 4
57   BX ← BX AND 0F000H       // isolate most significant nibble 58   if BX > 9000H then
59       BX ← BX + 6000H
60       Load Status Flags Into AH Register //LAHF 61      BX ← BX AND 0F000H
62      CH ← CH + BH
63      goto LOOP
64  else
65      CH ← CH + BH
66      goto LOOP
67  end if
-------------------------------------------------- END_PROCESS:
68  RESULT_BITS ← AX
69  Return RESULT_BITS, REPORT
```
##  Description

The algorithm performs BCD (Binary Coded Decimal) addition on two 16-bit numbers.<br>
Each nibble (4 bits) of the result is checked individually:<br>
If a nibble > 9, it adds 6 to correct it into valid BCD range.<br>
The process repeats for all four nibbles (000XH → X000H).<br>
The result is stored in RESULT_BITS, and a flag report is optionally updated.<br>

## Registers Usage Table

| Register | Purpose |
|----------|---------|
| **AX** | Holds the final combined 16-bit result of the BCD addition. |
| **BX** | Holds first operand |
| **DX** | Holds second operand |
| **CH** | High byte accumulator |
| **CL** | Step counter for operations |
| **AH** | Flag checking and temporary operations |
| **AL** | Low byte accumulator |

## End of Program
The algorithm stops after processing all 4 digits and saving the result.

## Notes
Based on 8086 Assembly structure (.MODEL SMALL, .DATA, .CODE).<br>
Suitable for educational use in microprocessor or computer organization labs.<br>
put logic and flags may vary depending on specific implementation details.<br>
Time Complexity: **O(1)** <br>
Space Complexity: **O(1)** <br>
