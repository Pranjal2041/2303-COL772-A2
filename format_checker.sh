KERBEROS_ID=$1
SHOULD_TRAIN=$2

# unzip -o $KERBEROS_ID.zip
cd $KERBEROS_ID

echo "Downloading Model"
# read model url from file "model_url.txt"
MODEL_NAME=$(cat model_url.txt)
# Strip of the trailing newline
MODEL_NAME=${MODEL_NAME%$'\n'}
gdown $MODEL_NAME --fuzzy

if [ $SHOULD_TRAIN == "true" ]; then
    echo "Starting Training"
    bash run_model.sh ../data/A2_train.jsonl ../data/A2_val.jsonl
fi

echo "Starting Evaluation"
bash run_model.sh test ../data/A2_val.jsonl predictions.jsonl

cd ..

echo "Evaluating Submission"
python evaluate_submission.py data/A2_val.jsonl $KERBEROS_ID/predictions.jsonl