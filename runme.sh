export CONFIG_FILE="./map.yaml"
export ZEROto100py="./0to100-latest/zero_to_one_hundred/main.py"
# main at run time
python $ZEROto100py "$@"
echo "$@"