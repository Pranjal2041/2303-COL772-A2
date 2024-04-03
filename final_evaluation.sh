export CUDA_VISIBLE_DEVICES=0

KERBEROS_ID=$1
SHOULD_TRAIN=$2

unzip -o $KERBEROS_ID.zip
cd $KERBEROS_ID


if [ $SHOULD_TRAIN == "true" ]; then
    echo "Starting Training"
    timeout "6h" bash run_model.sh ../data/A2_train.jsonl ../data/A2_val.jsonl
fi

echo "Starting Evaluation"
bash run_model.sh test ../data/A2_test.jsonl predictions_new.jsonl

cd ..

echo "Evaluating Submission"
python evaluate_submission.py data/A2_test.jsonl $KERBEROS_ID/predictions_new.jsonl