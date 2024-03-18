# Check if $1==test
if [ "$1" == "test" ]; then
    #  This is a sample submission, simply copy prediction file from data folder
    cp ../data/A2_val_prediction.jsonl $3
else
    #    Train the model
    echo "Training the model"
fi