# Create a CLTV script with a timestamp of 1495584032 and public key below:
op_push_data_4bytes_hex="04"

time_hex=$(printf '%08x' 1495584032)
time_hex_little_endian=$(echo "$time_hex" | sed 's/../& /g' | awk '{for(i=NF;i>0;i--) printf $i}')

op_checklocktimeverify="b1"
op_drop="75"
op_dup="76"
op_hash160="a9"
op_push_data_20bytes_hex="14"

publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey_hash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 | awk '{print $2}')

op_equalverify="88"
op_checksig="ac"

script_hex="${op_push_data_4bytes_hex}${time_hex_le}${op_checklocktimeverify}${op_drop}${op_dup}${op_hash160}${op_push_data_20bytes_hex}${publicKey_hash}${op_equalverify}${op_checksig}"

echo "$script_hex"
