# BIOL 2214 Week 6 Homework

## Debug this code

1. `import pickle` loads the `pickle` module so that Python can read the saved genetic code dictionary.
2. `genetic_code = pickle.load(...)` opens the pickle file and assigns the genetic code dictionary to the variable `genetic_code`.
3. `test_mRNA = "AUGGAAUUCUCGCUCUGAAGGUAA"` stores an mRNA sequence whose expected translation is `MEFSL` followed by a stop codon.
4. `def get_amino_acids(mRNA):` defines a function that accepts an mRNA sequence.
5. `i = 0` sets the first position to the beginning of the sequence.
6. `aa_sequence = []` creates an empty list for the translated amino acids.
7. `while (i + 3) < len(mRNA):` repeats the indented code while bases remain in the sequence.
8. `codon = mRNA[i:(i + 3)]` uses a string slice to select three bases beginning at position `i`.
9. `aa = genetic_code[codon]` uses the codon as a dictionary key and saves its amino acid as `aa`.
10. `if aa == "Stop":` checks the current codon is a stop codon.
11. `break` exits the loop when a stop codon is found.
12. `else:` gives the action to perform when the codon is not a stop codon.
13. `aa_sequence.append(aa)` adds the amino acid to the end of the list.
14. `i = i + 4` advances the starting position before the next loop.
15. `return "".join(aa_sequence)` joins the amino-acid list into one string and returns it.
16. `print(get_amino_acids(test_mRNA))` runs the function on the test sequence and prints its result.

The program does not raise an exception, but it gives `MNLLEV` instead of `MEFSL`. Therefore, this is a logical error. I added `pdb.set_trace()` after the program selected and translated each codon.

I checked `i`, `codon`, and `aa` in the debugger. The first codon began at `i = 0`, but the next codon began at `i = 4`. A codon has three bases, so the second codon should begin at `i = 3`. This showed that the error was:

```python
i = i + 4
```

I changed it to:

```python
i = i + 3
```

After this change, the test sequence returned the expected result:

```text
MEFSL
```

## Gobbler proteins

I used the corrected function in `translate_turkey.py` to translate the 15 DNA sequences in `Turkey_transcripts_15_coding.fasta`. I changed each DNA sequence to an RNA sequence with `replace("T", "U")`. I also changed `gbkey=CDS` in each header to `gbkey=AA`. The protein sequences were written to `Turkey_proteins_15.fasta`.
