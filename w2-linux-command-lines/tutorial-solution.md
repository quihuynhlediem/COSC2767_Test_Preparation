# Week 2 Tutorial
## Challenge 0
```bash
date
```

```bash
whoami
```

```bash
groups $(whoami)
```

```bash
echo Hello World
```

```bash
pwd
```

```bash
ls
```

```bash
cd ..
```

**Create folders**
```bash
mkdir folder1
mkdir folder2
```

**Create files**
```bash
touch file1.txt
touch file2.txt
```

**Create file and add content/Overwrite if existing**
```bash
echo 'Hello Qui Huynh' > greet.txt
```

**Add content to file**
```bash
echo 'Hello Mung Huynh' >> greet.txt
```

**Move/Rename File**
```bash
mv greet.txt hello.txt
mv hello.txt ./folder1
```

**Find file content inside a folder**
```bash
grep Hello -r ./folder1
```

**Find file content of**
```bash
grep Hello ./folder1/hello.txt
```

**Find files/folders via file name/folder name**
```bash
find .. -name "hello.*"
```

**Count how many times a word appear**
```bash
grep Hello -r . | wc -l
```

## Challenge 1
**Save count to a file count.txt**
```bash
echo $(grep Hello -r ./folder1 | wc -l) > ./count.txt
```

## Challenge 2
**Count how many times the word Romeo occurs, and compare with the word Juliet.**
```bash
touch shakesphear_wordcount.txt
echo "Romeo: $(grep -o Romeo ./shakespeare.txt | wc -l) >> shakesphear_wordcount.txt"
echo "Juliet: $(grep -o Juliet ./shakespeare.txt | wc -l) >> shakesphear_wordcount.txt"
```

## Challenge 3
```bash
mkdir dog
mkdir cat
mv $(find ./DATA -name 'cat*.*') ./cat
mv $(find ./DATA -name 'dog*.*') ./dog
```