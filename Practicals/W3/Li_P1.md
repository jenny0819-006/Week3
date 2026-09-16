# BIOL 2214 Week 1 Practical

## 1. What do these commands do?

### `man pwd`

This opens the manual page for `pwd`. The `pwd` command prints the full path of the current working directory.

### `ls -lh`

This lists files in the current directory in long format. The `-h` option displays file sizes in a human-readable form, such as KB or MB.

### `mkdir -p /test1/test2/test3`

This creates the nested directories `test1`, `test2`, and `test3`. The `-p` option creates any missing parent directories.

## 2. Turkey transcripts

The sequence file is:

```text
Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

### Copy the file

```bash
cp Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta Unix/sandbox/
```

### File size

```bash
wc -c Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

The file contains `18,569,410 bytes`.

### Number of lines

```bash
wc -l Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

The file contains `10,782 lines`.

### Number of characters

```bash
wc -m Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

The file contains `18,569,410 characters`.

### First line

```bash
head -n 1 Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

The first line is:

```text
>NM_001281869.1 Meleagris gallopavo trans-golgi network vesicle protein 23 homolog B (TVP23B), mRNA
```

### Last three lines

```bash
tail -n 3 Unix/DataFiles/M.gallopavo_GCF_905368555.1_transcripts.fasta
```

This prints the final three lines of the FASTA file. They include the final sequence record and its DNA sequence.

### Rename the copied file

```bash
mv Unix/sandbox/M.gallopavo_GCF_905368555.1_transcripts.fasta \
   Unix/sandbox/Turkey_transcripts.fasta
```

## 3. Clean the sandbox

### Full path

```bash
cd Unix/sandbox
pwd
```

The full path on my computer was:

```text
/Users/yaofan/Desktop/2026fall/bio 2214/IntroBiolComp-2026/Unix/sandbox
```

### Number of files

```bash
find . -maxdepth 1 -type f | wc -l
```

There were `2 files` before copying the turkey transcript file.

### Number of subdirectories

```bash
find . -mindepth 1 -maxdepth 1 -type d | wc -l
```

There were `0 subdirectories`.

### Remove the files and directories

```bash
rm -ri ./*
```

The `-i` option asks for confirmation before each removal.

### Verify the sandbox is empty

```bash
ls -la
```

Only `.` and `..` should remain after the cleanup.
