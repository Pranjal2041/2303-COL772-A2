KERBEROS_ID=$1
unzip -o $KERBEROS_ID.zip
cd $KERBEROS_ID

bash install_requirements.sh

echo "Starting Training"
bash run_model.sh ../data/A2_train.jsonl ../data/A2_val.jsonl

echo "Starting Evaluation"
bash run_model.sh test ../data/A2_val.jsonl predictions.jsonl

cd ..

echo "Evaluating Submission"
python evaluate_submission.py data/A2_val.jsonl $KERBEROS_ID/predictions.jsonl