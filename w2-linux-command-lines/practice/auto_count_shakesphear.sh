touch shakesphear_wordcount.txt
echo "Romeo: $(grep -o Romeo ./shakespeare.txt | wc -l)" >> shakesphear_wordcount.txt
echo "Juliet: $(grep -o Juliet ./shakespeare.txt | wc -l)" >> shakesphear_wordcount.txt