import pickle

genetic_code = pickle.load(open("genetic_code.pickle", "rb"))

def get_amino_acids(mRNA):
    i = 0
    aa_sequence = []

    while (i + 3) <= len(mRNA):
        codon = mRNA[i:(i + 3)]
        aa = genetic_code[codon]

        if aa == "Stop":
            break
        else:
            aa_sequence.append(aa)

        i = i + 3

    return "".join(aa_sequence)

headers = []
sequences = []

with open("Turkey_transcripts_15_coding.fasta", "r") as infile:
    for line in infile:
        line = line.rstrip()

        if line[0] == ">":
            headers.append(line)
        else:
            sequences.append(line)


# Translate every transcript and write the protein FASTA file.
with open("Turkey_proteins_15.fasta", "w") as outfile:
    for i in range(len(headers)):
        new_header = headers[i].replace("gbkey=CDS", "gbkey=AA")
        mRNA = sequences[i].replace("T", "U")
        protein = get_amino_acids(mRNA)

        outfile.write(new_header + "\n")
        outfile.write(protein + "\n")
