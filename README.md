# BCD Addition Algorithm (8086 Assembly → Pseudocode)

This pseudocode represents the logic of a **Binary-Coded Decimal (BCD) addition** algorithm,  
originally implemented in **8086 Assembly**.  
The algorithm adds two 16-bit numbers in BCD format and corrects digits greater than 9.

---

## Pseudocode

```text
BCD_ADD()
1    Initialize AX, BX, DX, CL, CH to 0
2    Set BX ← XXXXH          // First 16-bit number
3    Set DX ← XXXXH          // Second 16-bit number
4    Set CL ← 0              // Step counter

5    LOOP:
6        BX ← BX + DX

7        if CL == 0 then
8            goto CHECK_000XH
9        else if CL == 1 then
10           goto CHECK_00X0H
11       else if CL == 2 then
12           goto CHECK_0X00H
13       else if CL == 3 then
14           goto CHECK_X000H
15       end if

16       AH ← AH AND 1H
17       REPORT ← REPORT OR AH
18       AH ← CH
19       RESULT_BITS ← AX
20       goto END_PROCESS

--------------------------------------------------
CHECK_000XH:
21   CL ← 1
22   BX ← BX AND 000FH
23   if BX > 0009H then
24       BX ← BX + 0006H
25       BX ← BX AND 001FH
26       AL ← AL + BL
27       goto LOOP
28   else
29       AL ← AL + BL
30       goto LOOP
31   end if

--------------------------------------------------
CHECK_00X0H:
32   CL ← 2
33   BX ← BX AND 00F0H
34   if BX > 0090H then
35       BX ← BX + 0060H
36       BX ← BX AND 01F0H
37       AL ← AL + BL
38       CH ← CH + BH
39       goto LOOP
40   else
41       AL ← AL + BL
42       goto LOOP
43   end if

--------------------------------------------------
CHECK_0X00H:
44   CL ← 3
45   BX ← BX AND 0F00H
46   if BX > 0900H then
47       BX ← BX + 0600H
48       BX ← BX AND 1F00H
49       CH ← CH + BH
50       goto LOOP
51   else
52       CH ← CH + BH
53       goto LOOP
54   end if

--------------------------------------------------
CHECK_X000H:
55   CL ← 4
56   BX ← BX AND 0F000H
57   if BX > 9000H then
58       BX ← BX + 6000H
59       Load FLAGS into AH
60       BX ← BX AND 0F000H
61       CH ← CH + BH
62       goto LOOP
63   else
64       CH ← CH + BH
65       goto LOOP
66   end if

--------------------------------------------------
END_PROCESS:
67   Store RESULT_BITS ← AX
68   Terminate program
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
| **AX** | General data and partial result storage |
| **BX** | Holds first operand |
| **DX** | Holds second operand |
| **CH** | High byte accumulator |
| **CL** | Step counter for operations |
| **AH** | Flag checking and temporary operations |

## End of Program
The algorithm stops after processing all 4 digits and saving the result.

## Notes
Based on 8086 Assembly structure (.MODEL SMALL, .DATA, .CODE).<br>
Suitable for educational use in microprocessor or computer organization labs.<br>
put logic and flags may vary depending on specific implementation details.<br>
Time Complexity: **O(1)** <br>
Space Complexity: **O(1)** <br>
