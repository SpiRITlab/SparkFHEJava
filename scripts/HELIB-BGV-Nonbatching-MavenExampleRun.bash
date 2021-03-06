#!/usr/bin/env bash

ProjectRoot=..
cd $ProjectRoot

# generate example key pairs
./mvn -f pom-devel.xml exec:java -Dexec.mainClass=spiritlab.sparkfhe.example.nonbatching.KeyGenExample -Dexec.args="local HELIB BGV"

# generate example ciphertexts
./mvn -f pom-devel.xml exec:java -Dexec.mainClass=spiritlab.sparkfhe.example.nonbatching.EncDecExample -Dexec.args="local HELIB BGV gen/keys/my_public_key.txt gen/keys/my_secret_key.txt"

# run basic FHE arithmetic operation over encrypted data
./mvn -f pom-devel.xml exec:java -Dexec.mainClass=spiritlab.sparkfhe.example.nonbatching.BasicOPsExample -Dexec.args="local HELIB BGV gen/keys/my_public_key.txt gen/keys/my_secret_key.txt gen/records/$(ls gen/records | grep ptxt_long_0) gen/records/$(ls gen/records | grep ptxt_long_1)"

# run FHE dot product over two encrypted vectors
./mvn -f pom-devel.xml exec:java -Dexec.mainClass=spiritlab.sparkfhe.example.nonbatching.DotProductExample -Dexec.args="local HELIB BGV gen/keys/my_public_key.txt gen/keys/my_secret_key.txt gen/records/$(ls gen/records | grep vec_a) gen/records/$(ls gen/records | grep vec_b)"
#
# run FHE total sum over encrypted vector elements
./mvn -f pom-devel.xml exec:java -Dexec.mainClass=spiritlab.sparkfhe.example.nonbatching.TotalSumExample -Dexec.args="local HELIB BGV gen/keys/my_public_key.txt gen/keys/my_secret_key.txt gen/records/$(ls gen/records | grep vec)"