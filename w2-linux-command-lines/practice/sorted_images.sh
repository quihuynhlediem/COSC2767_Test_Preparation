mkdir dog
mkdir cat
mv $(find ./DATA -name 'cat*.*') ./cat
mv $(find ./DATA -name 'dog*.*') ./dog
